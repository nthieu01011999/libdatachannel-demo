#include "SDCard.h"

static size_t sizeOfFile(const char *url) {
    struct stat fStat;
	int fd = -1;

	fd = open(url, O_RDONLY);
	if (fd < 0) {
		return -1;
	}
    fstat(fd, &fStat);
	close(fd);

    return fStat.st_size;
}

void epochToTimes(uint32_t epoch, 
                  uint16_t& year, uint8_t& month, uint8_t& date,
                  uint8_t& hour, uint8_t& minute, uint8_t& second)
{
    std::tm t_tm = {};
    std::time_t timeValue = epoch;

    gmtime_r(&timeValue, &t_tm);
    year = t_tm.tm_year + 1900; /* Years since 1900 */
    month = t_tm.tm_mon + 1;    /* Months are 0-11 */
    date = t_tm.tm_mday;
    hour = t_tm.tm_hour;
    minute = t_tm.tm_min;
    second = t_tm.tm_sec;
} 

std::vector<std::string> splitString(std::string st, char delimeter) {
    std::vector<std::string> stGroups;
    stGroups.clear();
    int startInd = 0, stopInd = 0;

    for (int id = 0; id <= st.size(); id++) {
        if (st[id] == delimeter || id == st.size()) {
            stopInd = id;
            std::string tmp;
            tmp.append(st, startInd, stopInd - startInd);
            stGroups.push_back(tmp);
            startInd = stopInd + 1;
        }
    }

    return stGroups;
}

/*
    SDCard class implementation
*/
SDCard::SDCard() {
    mInsertion = eSDDetect::Removed;
}

SDCard::~SDCard() {

}

void SDCard::setURL(std::string sdPath) {
    mURL.assign(sdPath);
}

const char *SDCard::getURL() {
    return mURL.c_str();
}

void SDCard::setSDState(eSDDetect state) {
    mInsertion = state;
}

bool SDCard::isInserted() {
    if (mInsertion == eSDDetect::Inserted && mURL.empty() == false) {
        return true;
    }

    return false;
}

std::vector<SDRecord> SDCard::getAllPlaylists(std::string dateTime) {
    std::vector<SDRecord> listRecords;

    if (mInsertion == eSDDetect::Inserted) {
        qryPlayList(listRecords, dateTime);
    }

    return listRecords;
}

static bool sortByTime(SDRecord& rc1, SDRecord& rc2) {
    if (rc1.sortTime.hou != rc2.sortTime.hou) {
        return rc1.sortTime.hou > rc2.sortTime.hou;
    }

    if (rc1.sortTime.min != rc2.sortTime.min) {
        return rc1.sortTime.min > rc2.sortTime.min;
    }

    return (rc1.sortTime.sec > rc2.sortTime.sec);
}

static SDRecord nameFmtPaser(std::string& record) {    
    char ch[40];
    SDRecord rc = { 0 };
    auto sv = splitString(record, '_');
    struct {
        uint16_t yea;
        uint8_t mon, dat, hou, min, sec;
    } timeFmt;

    /*  Ex: <YY><MM><DD><hh><mm><ss>_<timestamp start>_<timestamp stop>_<fps>.<file type>
        [0] : <YY><MM><DD><hh><mm><ss>
        [1] : <timestamp start>
        [2] : <timestamp stop>
        [3] : <fps>
    */
    if (sv.size() != 4) { 
        return rc;
    }

    /* File description */
    memset(ch, 0, 40);
    sprintf(ch, "%s_%s_%s", sv[0].c_str(), sv[1].c_str(), sv[2].c_str());
    rc.fileName.assign(ch);

    /* Begin time */
    memset(ch, 0, 40);
    epochToTimes(stoi(sv[1]), 
                 timeFmt.yea, timeFmt.mon, timeFmt.dat,
                 timeFmt.hou, timeFmt.min, timeFmt.sec);
    rc.sortTime.hou = timeFmt.hou;
    rc.sortTime.min = timeFmt.min;
    rc.sortTime.sec = timeFmt.sec;
    sprintf(ch, "%d.%02d.%02d %02d:%02d:%02d",  timeFmt.yea, timeFmt.mon, timeFmt.dat,
                                                timeFmt.hou, timeFmt.min, timeFmt.sec);
    rc.beginTime.assign(ch);

    /* End time */
    memset(ch, 0, 40);
    epochToTimes(stoi(sv[2]), 
                 timeFmt.yea, timeFmt.mon, timeFmt.dat,
                 timeFmt.hou, timeFmt.min, timeFmt.sec);
    sprintf(ch, "%d.%02d.%02d %02d:%02d:%02d",  timeFmt.yea, timeFmt.mon, timeFmt.dat,
                                                timeFmt.hou, timeFmt.min, timeFmt.sec);
    rc.beginTime.assign(ch);

    /* Duration in seconds */
    rc.durationInSecs = stoi(sv[2]) - stoi(sv[1]);

    return rc;
}

void SDCard::qryPlayList(std::vector<SDRecord>& listRecords, std::string dateTime) {
    std::string pathToVideoLists = mURL + std::string("/video/") + dateTime;
    DIR *dir = opendir(pathToVideoLists.c_str());

    APP_DBG("Path to video lists: %s\n", pathToVideoLists.c_str());

    if (dir == nullptr) {
        APP_DBG("SD Card opens failure, error: %s", strerror(errno));
        return;
    }

    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
        /* Push the name of every file, exclude current directory (".") 
           and parent directory ("..")
        */
        if (strcmp(entry->d_name, ".") != 0 && strcmp(entry->d_name, "..") != 0) {
            std::string st(entry->d_name, sizeof(entry->d_name));
            uint8_t n = st.find('.');
            st = st.substr(0, n);
            
            auto rc = nameFmtPaser(st);
            if (rc.durationInSecs != 0) {
                listRecords.emplace_back(rc);
            }
        }
    }
    
    if (listRecords.size()) {
        sort(listRecords.begin(), listRecords.end(), sortByTime);
    }
    closedir(dir);
}


/*
    SDPlayback class implementation
*/
SDPlayback::SDPlayback() {
    mPbStatus = ePbStatus::Stopped;
}

SDPlayback::~SDPlayback() {

}

void SDPlayback::assignRecord(std::string pathToRecords, std::string dateTime, std::string name) {
    mTrack[VIDEO_TRACK_ID].url = pathToRecords + std::string("/video/") + dateTime + std::string("/") + name + std::string("_13.h264");
    mTrack[AUDIO_TRACK_ID].url = pathToRecords + std::string("/audio/") + dateTime + std::string("/") + name + std::string(".g711");

    auto sv = splitString(name, '_');
    mDurationInSec = std::stoi(sv[2]) - std::stoi(sv[1]);

    APP_DBG("Video URL: %s\n", mTrack[VIDEO_TRACK_ID].url.c_str());
    APP_DBG("Audio URL: %s\n", mTrack[AUDIO_TRACK_ID].url.c_str());
}

void SDPlayback::start() {
    if (!mTrack[VIDEO_TRACK_ID].url.empty()) {
        mTrack[VIDEO_TRACK_ID].cursor = 0;
        mTrack[VIDEO_TRACK_ID].fileSize = sizeOfFile(mTrack[VIDEO_TRACK_ID].url.c_str());
    }
    
    if (!mTrack[AUDIO_TRACK_ID].url.empty()) {
        mTrack[AUDIO_TRACK_ID].cursor = 0;
        mTrack[AUDIO_TRACK_ID].fileSize = sizeOfFile(mTrack[AUDIO_TRACK_ID].url.c_str());
    }

    if ((mTrack[VIDEO_TRACK_ID].fileSize <= 0) || (mTrack[AUDIO_TRACK_ID].fileSize <= 0)) {
        mPbStatus = ePbStatus::Error;
    }
}

void SDPlayback::stop() {
    mTrack[VIDEO_TRACK_ID].url.clear();
    mTrack[VIDEO_TRACK_ID].cursor = mTrack[VIDEO_TRACK_ID].fileSize = 0;

    mTrack[AUDIO_TRACK_ID].url.clear();
    mTrack[AUDIO_TRACK_ID].cursor = mTrack[VIDEO_TRACK_ID].fileSize = 0;
}

void SDPlayback::loadNextSample(ePbType type) {
    if (mPbStatus != ePbStatus::Playing) {
        return;
    }

    if (type == ePbType::Video) {
        loadNextSampleH264();
    }
    else {
        loadNextSampleG711();
    }
}

void SDPlayback::setPbControl(ePbControl pbc) {
    switch (pbc) {
    case ePbControl::Stop: 
        mPbStatus = ePbStatus::Stopped;
    break;
    case ePbControl::Play: 
        mPbStatus = ePbStatus::Playing;
    break;
    case ePbControl::Pause:
        mPbStatus = ePbStatus::Pausing;
    break;
    case ePbControl::Seek:
        mPbStatus = ePbStatus::Playing;
    break;
    default:
    break;
    }
}

SDPlayback::ePbStatus SDPlayback::getPbState() {
    return mPbStatus;
}

void SDPlayback::seekPosInSecs(uint32_t inSecs) {
    if (inSecs < mDurationInSec) {
        mTrack[VIDEO_TRACK_ID].cursor = (inSecs * mTrack[VIDEO_TRACK_ID].fileSize) / mDurationInSec;
        mTrack[AUDIO_TRACK_ID].cursor = (inSecs * mTrack[AUDIO_TRACK_ID].fileSize) / mDurationInSec;
    }
}

void SDPlayback::setSpeed(uint8_t val) {
    mSpeed = val;
}

bool SDPlayback::isNALU4(size_t startPos, std::byte *buf) {
    return (buf[startPos + 0] == std::byte{0} &&
            buf[startPos + 1] == std::byte{0} &&
            buf[startPos + 2] == std::byte{0} &&
            buf[startPos + 3] == std::byte{1});
}

bool SDPlayback::isNALU3(size_t startPos, std::byte *buf) {
    return (buf[startPos + 0] == std::byte{0} &&
            buf[startPos + 1] == std::byte{0} &&
            buf[startPos + 2] == std::byte{1});
}

size_t SDPlayback::samplingTrack(ePbType type, std::byte *buf, uint32_t bufSz) {
    size_t maxSz, cursor;
    char *url = NULL;
    int fd = -1;

    if (type == ePbType::Video) {
        url = (char*)mTrack[VIDEO_TRACK_ID].url.c_str();
        maxSz = mTrack[VIDEO_TRACK_ID].fileSize;
        cursor = mTrack[VIDEO_TRACK_ID].cursor;
    }
    else {
        url = (char*)mTrack[AUDIO_TRACK_ID].url.c_str();
        maxSz = mTrack[AUDIO_TRACK_ID].fileSize;
        cursor = mTrack[AUDIO_TRACK_ID].cursor;
    }

    if (cursor >= maxSz) {
        APP_ERR("[ERR] TYPE %s\n", type == ePbType::Video ? "Video" : "Audio");
        APP_ERR("[ERR] FILE %s, LINE %d\n", __FILE__, __LINE__);
        APP_ERR("[ERR] CURSOR: %ld, MAX_SIZE: %ld\n", cursor, maxSz);
        return 0;
    }

	fd = open(url, O_RDONLY);
	if (fd < 0) {
        APP_ERR("[ERR] TYPE %s\n", type == ePbType::Video ? "Video" : "Audio");
        APP_ERR("[ERR] FILE %s, LINE %d\n", __FILE__, __LINE__);
        APP_ERR("[ERR] URL: %s\n", url);
		return 0;
	}

    size_t remain = maxSz - cursor;
    size_t validSz = (remain > bufSz ? bufSz : remain);
    size_t sz = pread(fd, buf, validSz, cursor);

	close(fd);

	return sz;
}

size_t SDPlayback::loadNextSampleH264() {
    enum {
        NALU_NOTFOUND = 0,
        NALU_BEGIN,
        NALU_END,
    };

    size_t beginNalu = NALU_NOTFOUND;
    bool isFound = false;
    std::byte *bytes = (std::byte*)malloc(sizeof(std::byte) * H264_MAX_FRAME_LOAD);

    if (bytes == NULL) {
        APP_ERR("[ERR] FILE %s, LINE %d", __FILE__, __LINE__);
        return 0;
    }

    h264Samples.clear();
    std::vector<std::byte> tmp;

    for (uint16_t cnts = 0; cnts < mSpeed; ++cnts) {
        beginNalu = NALU_NOTFOUND;
        isFound = false;

        do {
            memset(bytes, 0, H264_MAX_FRAME_LOAD);
            size_t totalSamples = samplingTrack(ePbType::Video, bytes, H264_MAX_FRAME_LOAD);

            if (totalSamples <= 4) {
                free(bytes);
                mPbStatus = ePbStatus::Done;
                
                return 0;
            }

            for (size_t id = 0; id < (totalSamples - 4); ++id) {
                if (isNALU4(id, bytes) == true) {
                    ++beginNalu;
                }

                if (beginNalu == NALU_NOTFOUND) {
                    ++mTrack[VIDEO_TRACK_ID].cursor;
                    continue;
                }
                else if (beginNalu == NALU_BEGIN) {
                    tmp.emplace_back(reinterpret_cast<const std::byte>(bytes[id]));
                    ++mTrack[VIDEO_TRACK_ID].cursor;
                }
                else {
                    isFound = true;
                    break;
                }
            }
        } while (!isFound);

        if (isFound) {
            /* Transfer 00 00 00 01 -> 00 00 AC CE (Size of payload) */
            uint32_t naluLen = htonl(static_cast<uint32_t>(tmp.size() - 4));
    
            std::copy(reinterpret_cast<const std::byte *>(&naluLen),
                      reinterpret_cast<const std::byte *>(&naluLen) + sizeof(naluLen),
                      tmp.begin());

            h264Samples.insert(h264Samples.end(), tmp.begin(), tmp.end());
            tmp.clear();
        }
    }
    free(bytes);

    return h264Samples.size();
}

size_t SDPlayback::loadNextSampleG711() {
    std::byte *bytes = (std::byte*)malloc(sizeof(std::byte) * ALAW_MAX_FRAME_LOAD);

    if (bytes == NULL) {
        APP_ERR("[ERR] FILE %s, LINE %d", __FILE__, __LINE__);
        return 0;
    }

    g711Samples.clear();

    for (uint16_t cnts = 0; cnts < /* mPlaySpeed */1; ++cnts) {
        memset(bytes, 0, ALAW_MAX_FRAME_LOAD);
        int totalSamples = samplingTrack(ePbType::Audio, bytes, ALAW_MAX_FRAME_LOAD);
        
        if (totalSamples == 0) {
            break;
        }
        
        g711Samples.insert(g711Samples.end(), bytes, bytes + totalSamples);

        mTrack[AUDIO_TRACK_ID].cursor += totalSamples;
    }
    free(bytes);

    return g711Samples.size();
}