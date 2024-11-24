include(FetchContent)

FetchContent_Declare(Qbackend
    GIT_REPOSITORY https://github.com/anischali/Qbackend.git
    GIT_TAG main
)
FetchContent_MakeAvailable(Qbackend)

FetchContent_Declare(lite-p2p
    GIT_REPOSITORY https://github.com/anischali/lite-p2p.git
    GIT_TAG main
)
FetchContent_MakeAvailable(lite-p2p)

FetchContent_Declare(fmt
  GIT_REPOSITORY https://github.com/fmtlib/fmt.git
  GIT_TAG 9.0.0
)
FetchContent_MakeAvailable(fmt)

FetchContent_Declare(nlohmann_json
  GIT_REPOSITORY https://github.com/nlohmann/json.git
  GIT_TAG v3.11.2
)
FetchContent_MakeAvailable(nlohmann_json)

if (ANDROID)
    include(FetchContent)
    FetchContent_Declare(
        android_openssl
        DOWNLOAD_EXTRACT_TIMESTAMP true
        URL https://github.com/KDAB/android_openssl/archive/refs/heads/master.zip
    )
    FetchContent_MakeAvailable(android_openssl)
    include(${android_openssl_SOURCE_DIR}/android_openssl.cmake)
endif()
