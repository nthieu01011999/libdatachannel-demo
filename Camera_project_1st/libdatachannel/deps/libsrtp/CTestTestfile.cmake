# CMake generated Testfile for 
# Source directory: /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp
# Build directory: /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(datatypes_driver "datatypes_driver" "-v")
set_tests_properties(datatypes_driver PROPERTIES  _BACKTRACE_TRIPLES "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;316;add_test;/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;0;")
add_test(cipher_driver "cipher_driver" "-v")
set_tests_properties(cipher_driver PROPERTIES  _BACKTRACE_TRIPLES "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;321;add_test;/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;0;")
add_test(kernel_driver "kernel_driver" "-v")
set_tests_properties(kernel_driver PROPERTIES  _BACKTRACE_TRIPLES "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;326;add_test;/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;0;")
add_test(rdbx_driver "rdbx_driver" "-v")
set_tests_properties(rdbx_driver PROPERTIES  _BACKTRACE_TRIPLES "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;331;add_test;/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;0;")
add_test(replay_driver "replay_driver" "-v")
set_tests_properties(replay_driver PROPERTIES  _BACKTRACE_TRIPLES "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;336;add_test;/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;0;")
add_test(roc_driver "roc_driver" "-v")
set_tests_properties(roc_driver PROPERTIES  _BACKTRACE_TRIPLES "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;341;add_test;/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;0;")
add_test(srtp_driver "srtp_driver" "-v")
set_tests_properties(srtp_driver PROPERTIES  _BACKTRACE_TRIPLES "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;347;add_test;/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;0;")
add_test(test_srtp "test_srtp")
set_tests_properties(test_srtp PROPERTIES  _BACKTRACE_TRIPLES "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;359;add_test;/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;0;")
add_test(rtpw_test "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/rtpw_test.sh" "-w" "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/words.txt")
set_tests_properties(rtpw_test PROPERTIES  _BACKTRACE_TRIPLES "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;366;add_test;/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;0;")
add_test(rtpw_test_gcm "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/rtpw_test_gcm.sh" "-w" "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/words.txt")
set_tests_properties(rtpw_test_gcm PROPERTIES  _BACKTRACE_TRIPLES "/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;370;add_test;/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeLists.txt;0;")
