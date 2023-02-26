

const SIGNALING_SERVER_URL = 'https://signaling.thecitizen.support:9443';

const PC_CONFIG = {
    sdpSemantics: 'unified-plan',
    iceCandidatePoolSize: 10,
    iceServers: [
        {
            urls: ['stun:stun1.l.google.com:19302', 'stun:stun2.l.google.com:19302'], // free stun server
        }
    ]
};

let peerConnections = []

const mediaConstraints = {
    audio: true,
    video: true
};

function connect() {
    let user = document.getElementById('txtUser').value;
    let room = document.getElementById('txtRoom').value;
    if (!user) {
        alert('Enter username');
        return;
    }
    else if (!room) {
        alert('Enter room');
        return;
    }
    let connectionUrl = SIGNALING_SERVER_URL
        + '?user=' + user
        + '&room=' + room
        + '&token=token'
    let socket = io(connectionUrl, { autoConnect: false });

    socket.on('connect', (a) => {
        console.log('Socket connected: ' + socket.id);
        document.getElementById('txtUser').style.display = 'none';
        document.getElementById('txtRoom').style.display = 'none';
        document.getElementById('btnConnect').style.display = 'none';
        navigator.mediaDevices.getUserMedia(mediaConstraints)
            .then((localStream) => {
                document.getElementById("local_video").srcObject = localStream;
            });
        fetch("https://telecom.thecitizen.support/signaling/get-ice", { mode: "no-cors" })
            .then(res => res.json())
            .then(data => {
                PC_CONFIG.iceServers = [{
                    urls: data.ice_urls,
                    username: data.ice_username,
                    credential: data.ice_credential
                }];
            })
    });

    socket.on('ready', (data) => {
        console.log(data.sid + " joined")
        let pc = createPeerConnection(data.sid);
        sendOffer(pc);
    });

    socket.on('disconnect', () => {
        console.log('Disconnected');
        for (const pc in peerConnections) {
            if (pc) {
                // pc.close();
                console.log('Peer connection closed');
            }
        }
    });

    socket.on('data', (data) => {
        handleSignalingData(data);
    });

    // WebRTC methods

    let createPeerConnection = (id) => {
        try {
            let pc = new RTCPeerConnection(PC_CONFIG);
            pc.id = id;
            peerConnections[id] = pc;
            pc.onicecandidate = event => {
                if (event.candidate) {
                    socket.emit('data', {
                        from: socket.id,
                        to: pc.id,
                        data: { type: 'ice-candidate', 'candidate': event.candidate }
                    });
                }
            };

            pc.ontrack = function (event) {
                console.log("Track received from " + pc.id)
                var pcid = pc.id
                var video = document.getElementById(pcid);
                if (!video) {
                    video = document.createElement("video")
                    video.id = pcid;
                    video.width = 300;
                    document.getElementById("rv").append(video);
                }
                video.autoplay = true;
                video.srcObject = event.streams[0];
            };

            pc.onconnectionstatechange = () => {
                if (pc.connectionState === 'disconnected') {
                    console.log("PeerConnection " + pc.id + " disconnected")
                    document.getElementById(pc.id).remove();
                    pc.close();
                }
            };

            console.log('PeerConnection created for ' + pc.id);
            return pc;
        } catch (error) {
            console.error('PeerConnection failed: ', error);
        }
    };

    let sendOffer = (pc) => {
        navigator.mediaDevices.getUserMedia(mediaConstraints)
            .then((localStream) => {
                localStream.getTracks().forEach((track) => pc.addTrack(track, localStream));
            }).then(() => {
                const offer = pc.createOffer();
                pc.setLocalDescription(offer).then(() => {
                    socket.emit('data', { from: socket.id, to: pc.id, data: pc.localDescription });
                    console.log('Offer sent  to ' + pc.id);
                });
            });
    };

    let sendAnswer = (pc, data) => {
        pc.setRemoteDescription(new RTCSessionDescription(data))
            .then(_ => {
                navigator.mediaDevices.getUserMedia(mediaConstraints)
                    .then((localStream) => {
                        localStream.getTracks().forEach((track) => pc.addTrack(track, localStream));
                    })
                    .then(() => {
                        pc.createAnswer()
                            .then(answer => pc.setLocalDescription(answer))
                            .then(_ => {
                                socket.emit('data', { from: socket.id, to: pc.id, data: pc.localDescription });
                                console.log('Answer sent from to ' + pc.id);
                            });
                    })
            });
    };

    let handleSignalingData = (data) => {
        console.log(data)
        switch (data.data.type) {
            case 'offer':
                if (peerConnections[data.from]) return;
                console.log("Offer received from " + data.from)
                var pc = createPeerConnection(data.from);
                if (pc) {
                    sendAnswer(pc, data.data);
                }
                break;
            case 'answer':
                console.log("Answer received from " + data.from)
                var pc = peerConnections[data.from];
                if (pc) {
                    pc.setRemoteDescription(new RTCSessionDescription(data.data));
                }
                break;
            case 'ice-candidate':
                var pc = peerConnections[data.from];
                console.log("ICE received from " + data.from)
                const candidate = new RTCIceCandidate(data.data.candidate);
                pc.addIceCandidate(candidate);
                break;
            case 'error':
                console.log("Error");
                break;
            default:
                console.log(data.type);
        }
    };

    socket.connect();
}