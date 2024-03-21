const iceConnectionLog = document.getElementById('ice-connection-state'),
    iceGatheringLog = document.getElementById('ice-gathering-state'),
    signalingLog = document.getElementById('signaling-state'),
    dataChannelLog = document.getElementById('data-channel');

const clientId = randomId(10);
// const clientId = "ClientFromBrowser";
const websocket = new WebSocket('ws://42.116.138.38:8089/' + clientId);

websocket.onopen = () => {
    document.getElementById('start').disabled = false;
}

websocket.onmessage = async (evt) => {
    if (typeof evt.data !== 'string') {
        return;
    }
    const message = JSON.parse(evt.data);
    if (message.type == "offer") {
        document.getElementById('offer-sdp').textContent = message.sdp;
        await handleOffer(message)
    }
}

let pc = null;
let dc = null;

function createPeerConnection() {
    const config = {
        bundlePolicy: "max-bundle",
    };

    // if (document.getElementById('use-stun').checked) {
    //     config.iceServers = [{urls: ['stun:stun.l.google.com:19302']}];
    // }
    config.iceServers = [{urls: ['stun:42.116.138.35:3478']}];

    let pc = new RTCPeerConnection(config);

    // Register some listeners to help debugging
    pc.addEventListener('iceconnectionstatechange', () =>
        iceConnectionLog.textContent += ' -> ' + pc.iceConnectionState);
    iceConnectionLog.textContent = pc.iceConnectionState;

    pc.addEventListener('icegatheringstatechange', () =>
        iceGatheringLog.textContent += ' -> ' + pc.iceGatheringState);
    iceGatheringLog.textContent = pc.iceGatheringState;

    pc.addEventListener('signalingstatechange', () =>
        signalingLog.textContent += ' -> ' + pc.signalingState);
    signalingLog.textContent = pc.signalingState;

    // Receive audio/video track
    pc.ontrack = (evt) => {
        var video;
        document.getElementById('media').style.display = 'block';
        video = document.getElementById('video');
        video.srcObject = evt.streams[0];
        video.play();
    };

    // Receive data channel
    pc.ondatachannel = (evt) => {
        dc = evt.channel;

        dc.onopen = () => {
            dataChannelLog.textContent += '- open\n';
            dataChannelLog.scrollTop = dataChannelLog.scrollHeight;
        };

        let dcTimeout = null;
        dc.onmessage = (evt) => {
            if (typeof evt.data !== 'string') {
                return;
            }

            console.log("onMessage: ", evt.data);

            // dataChannelLog.textContent += '< ' + evt.data + '\n';
            // dataChannelLog.scrollTop = dataChannelLog.scrollHeight;

            // dcTimeout = setTimeout(() => {
            //     if (!dc) {
            //         return;
            //     }
            //     const message = `Pong ${currentTimestamp()}`;
            //     dataChannelLog.textContent += '> ' + message + '\n';
            //     dataChannelLog.scrollTop = dataChannelLog.scrollHeight;
            //     dc.send(message);
            // }, 1000);

            const JS = JSON.parse(evt.data);
            
            /* Print playlist records */
            if (JS.Command === "Playlist" && JS.Type === "Respond") {
                const playlistContainer = document.getElementById('playlist-container');
                const playlists = JS.Content.Playlists;
                
                playlistContainer.innerHTML = ''; // Clear

                JS.Content.Playlists.forEach((playlist, index) => {
                    const playlistItem = document.createElement('div');
                    playlistItem.className = 'playlist-item';
                    
                    const parts = playlist.FileName.split('_');
                    const beginTime = parseInt(parts[1], 10);
                    const endTime = parseInt(parts[2], 10);

                    playlistItem.textContent = epochToDateTime(beginTime) + '-' + epochToDateTime(endTime);
                
                    // Attach a click event listener to each playlist item
                    playlistItem.addEventListener('click', () => {
                        const parts = playlist.FileName.split('_');
                        const beginTime = parseInt(parts[1], 10);
                        const endTime = parseInt(parts[2], 10);
                        
                        const msg = JSON.stringify({
                            Id: "camerainfake0134",
                            Command: "Playback",
                            Type: "Request",
                            Content: {
                                FileName: playlist.FileName,
                                EndTime: epochToDateTime(endTime),
                                BeginTime: epochToDateTime(beginTime),
                                Status: "Play",
                                SeekPos: 0
                            },
                        });

                        dc.send(msg);
                    });
                
                    playlistContainer.appendChild(playlistItem);
                });
            }
        }

        dc.onclose = () => {
            clearTimeout(dcTimeout);
            dcTimeout = null;
            dataChannelLog.textContent += '- close\n';
            dataChannelLog.scrollTop = dataChannelLog.scrollHeight;
        };
    }

    return pc;
}

async function waitGatheringComplete() {
    return new Promise((resolve) => {
        if (pc.iceGatheringState === 'complete') {
            resolve();
        } else {
            pc.addEventListener('icegatheringstatechange', () => {
                if (pc.iceGatheringState === 'complete') {
                    resolve();
                }
            });
        }
    });
}

async function sendAnswer(pc) {
    await pc.setLocalDescription(await pc.createAnswer());
    await waitGatheringComplete();

    const answer = pc.localDescription;
    document.getElementById('answer-sdp').textContent = answer.sdp;

    websocket.send(JSON.stringify({
        id: "camerainfake0134",
        type: answer.type,
        sdp: answer.sdp,
    }));
}

async function handleOffer(offer) {
    pc = createPeerConnection();
    await pc.setRemoteDescription(offer);
    await sendAnswer(pc);
}

function sendRequest() {
    websocket.send(JSON.stringify({
        id: "camerainfake0134",
        type: "request",
    }));
}

function start() {
    document.getElementById('start').style.display = 'none';
    document.getElementById('stop').style.display = 'inline-block';
    document.getElementById('media').style.display = 'block';
    sendRequest();
}

function stop() {
    document.getElementById('stop').style.display = 'none';
    document.getElementById('media').style.display = 'none';
    document.getElementById('start').style.display = 'inline-block';

    // close data channel
    if (dc) {
        dc.close();
        dc = null;
    }

    // close transceivers
    if (pc.getTransceivers) {
        pc.getTransceivers().forEach((transceiver) => {
            if (transceiver.stop) {
                transceiver.stop();
            }
        });
    }

    // close local audio/video
    pc.getSenders().forEach((sender) => {
        const track = sender.track;
        if (track !== null) {
            sender.track.stop();
        }
    });

    // close peer connection
    pc.close();
    pc = null;
}

// Helper function to generate a random ID
function randomId(length) {
  const characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  const pickRandom = () => characters.charAt(Math.floor(Math.random() * characters.length));
  return [...Array(length) ].map(pickRandom).join('');
}

// Helper function to generate a timestamp
let startTime = null;
function currentTimestamp() {
    if (startTime === null) {
        startTime = Date.now();
        return 0;
    } else {
        return Date.now() - startTime;
    }
}

function btnTouchHdl(direction) {
    console.log(`Button pressed: ${direction}`);

    if (dc.readyState === 'open') {
        const msg = JSON.stringify({
                            Id: "camerainfake0134",
                            Command: "PanTilt",
                            Type: "Request",
                            Content: {
                                Direction: direction
                            }
                        });
        console.log(msg);
        dc.send(msg);
    }
    else {
        alert('DataChannel is not open. Cannot send data.');
    }
}

function btnPlayListHdl(datetime) {
    console.log(`PlayList record: ${datetime}`);

    if (datetime === '2023.11.19') {
        const msg = JSON.stringify({
            Id: "camerainfake0134",
            Type: "Request",
            Command: "Playlist",
            Content: {
                Datetime: {
                    Year: 2023,
                    Month: 11,
                    Date: 19
                }
            }
        });
        console.log(msg);
        dc.send(msg);
    }
}

document.addEventListener('DOMContentLoaded', function () {
	var video = document.getElementById('video');
    var isTrue = false;

    video.addEventListener('play', function () {
        console.log('PLAYBACK -> PLAY');
        const msg = JSON.stringify({
                    Id: "camerainfake0134",
                    Command: "Playback",
                    Type: "Request",
                    Content: {
                        FileName: "20231119070000_1700377200_1700377500",  
                        EndTime: "2023.11.19 07:00:00", 
                        BeginTime: "2023.11.19 07:05:00",
                        Status: "Resume",
                        SeekPos: 0
                    }
        });
        console.log(msg);
        dc.send(msg);
    });

	video.addEventListener('pause', function () {
        console.log('PLAYBACK -> PAUSE');
        
        const msg = JSON.stringify({
                    Id: "camerainfake0134",
                    Command: "Playback",
                    Type: "Request",
                    Content: {
                        FileName: "20231119070000_1700377200_1700377500",  
                        EndTime: "2023.11.19 07:00:00", 
                        BeginTime: "2023.11.19 07:05:00",
                        Status: "Pause",
                        SeekPos: 0
                    }
        });
        console.log(msg);
        dc.send(msg);
    });
});

function hdlSTOP() {
    console.log('PLAYBACK -> STOP');
    const msg = JSON.stringify({
        Id: "camerainfake0134",
        Command: "Playback",
        Type: "Request",
        Content: {
            FileName: "20231119070000_1700377200_1700377500",  
            EndTime: "2023.11.19 07:00:00", 
            BeginTime: "2023.11.19 07:05:00",
            Status: "Stop",
            SeekPos: 0
        }
    });
    console.log(msg);
    dc.send(msg);
}

function hdlPAUSE() {
    console.log('PLAYBACK -> PAUSE');
    const msg = JSON.stringify({
        Id: "camerainfake0134",
        Command: "Playback",
        Type: "Request",
        Content: {
            FileName: "20231119070000_1700377200_1700377500",  
            EndTime: "2023.11.19 07:00:00", 
            BeginTime: "2023.11.19 07:05:00",
            Status: "Pause",
            SeekPos: 0
        }
    });
    console.log(msg);
    dc.send(msg);
}

function hdlRESUME() {
    console.log('PLAYBACK -> RESUME');
    const msg = JSON.stringify({
        Id: "camerainfake0134",
        Command: "Playback",
        Type: "Request",
        Content: {
            FileName: "20231119070000_1700377200_1700377500",  
            EndTime: "2023.11.19 07:00:00", 
            BeginTime: "2023.11.19 07:05:00",
            Status: "Resume",
            SeekPos: 0
        }
    });
    console.log(msg);
    dc.send(msg);
}

function hdlSEEK() {
    const seekPosElement = document.getElementById("seeking-pos");
    const seekPosValue = parseInt(seekPosElement.value, 10);

    const msg = JSON.stringify({
        Id: "camerainfake0134",
        Command: "Playback",
        Type: "Request",
        Content: {
            FileName: "20231119070000_1700377200_1700377500",  
            EndTime: "2023.11.19 07:00:00", 
            BeginTime: "2023.11.19 07:05:00",
            Status: "Seek",
            SeekPos: seekPosValue
        }
    });
    console.log(msg);
    dc.send(msg);
}

function epochToDateTime(timestamp) {
    const date = new Date(timestamp * 1000);

    const year = date.getUTCFullYear();
    const month = String(date.getUTCMonth() + 1).padStart(2, '0');
    const day = String(date.getUTCDate()).padStart(2, '0');
    const hours = String(date.getUTCHours()).padStart(2, '0');
    const minutes = String(date.getUTCMinutes()).padStart(2, '0');
    const seconds = String(date.getUTCSeconds()).padStart(2, '0');

    return `${year}.${month}.${day} ${hours}:${minutes}:${seconds}`;
}