include(FetchContent)

FetchContent_Declare(Qbackend
  GIT_REPOSITORY https://github.com/anischali/Qbackend.git
  GIT_TAG main
)
FetchContent_MakeAvailable(Qbackend)

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