#ifndef __SDCARD_H
#define __SDCARD_H

#include <vector>
#include <stdint.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>
#include <cstddef>
#include <cstring>
#include <dirent.h>
#include <ctime>
#include <algorithm>
#include <iostream>

#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>

#define H264_MAX_FRAME_LOAD     (2 * 1024)
#define ALAW_MAX_FRAME_LOAD     (512)

#if 1
#define APP_ERR(fmt, ...)     printf("\x1B[31m" fmt "\x1B[0m", ##__VA_ARGS__)
#define APP_DBG(fmt, ...)     printf("\x1B[32m" fmt "\x1B[0m", ##__VA_ARGS__)
#define APP_PRINT(fmt, ...)   printf("\x1B[33m" fmt "\x1B[0m", ##__VA_ARGS__)
#else
#define ERROR(fmt, ...)
#define APP_DBG(fmt, ...)
#define APP_PRINT(fmt, ...)
#endif

#define TEST_SDCARD_URL ("/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/examples/streamer/samples/records")


typedef struct {
    uint8_t orderNbr;
    uint8_t type;
    uint32_t durationInSecs;
    std::string fileName;
    std::string beginTime;
    std::string endTime;

    /* This structure support sorting */
    struct {
        uint8_t hou, min, sec;
    } sortTime;
} SDRecord;

/*------------------------------------------------------------------------------*/
class SDCard {
public:
    enum class eSDDetect { 
        Removed,
        Inserted = !Removed
    };

    SDCard();
    ~SDCard();
    void setURL(std::string sdPath); //path store
    const char *getURL();
    void setSDState(eSDDetect state);
    bool isInserted();
    std::vector<SDRecord> getAllPlaylists(std::string dateTime);

private:
    std::string mURL;
    eSDDetect mInsertion;

    void qryPlayList(std::vector<SDRecord>& listRecords, std::string dateTime);
};

/*------------------------------------------------------------------------------*/
class SDPlayback {
public:
    enum class ePbType    { Audio, Video };
    enum class ePbControl { Stop, Play, Pause, Seek };
    enum class ePbStatus  { Error, Playing, Pausing, Done, Stopped };
    
    SDPlayback();
    ~SDPlayback();
    void assignRecord(std::string pathToRecords, std::string dateTime, std::string name);
    void start();
    void stop();
    void loadNextSample(ePbType type);
    ePbStatus getPbState();
    void setPbControl(ePbControl pbc);
    void seekPosInSecs(uint32_t inSecs);
    void setSpeed(uint8_t val);
private:
    #define VIDEO_TRACK_ID  (0)
    #define AUDIO_TRACK_ID  (1)

    struct {
        size_t cursor;
        size_t fileSize;
        std::string url;
    } mTrack[2];

    ePbStatus mPbStatus;
    uint32_t mDurationInSec;
    uint8_t mSpeed = 1;

    bool isNALU4(size_t startPos, std::byte *buf);
    bool isNALU3(size_t startPos, std::byte *buf);
    size_t samplingTrack(ePbType type, std::byte *buf, uint32_t bufSz);
    size_t loadNextSampleH264();
    size_t loadNextSampleG711();

public:
    std::vector<std::byte> h264Samples;
    std::vector<std::byte> g711Samples;

};

/* Variables for testing */
extern SDCard testSDCARD;
extern SDPlayback testPLAYBACK;

/* Utilities function prototype */
extern std::vector<std::string> splitString(std::string st, char delimeter);
extern void epochToTimes(uint32_t epoch, 
                         uint16_t& year, uint8_t& month, uint8_t& date,
                         uint8_t& hour, uint8_t& minute, uint8_t& second);


#endif /* __SDCARD_H */