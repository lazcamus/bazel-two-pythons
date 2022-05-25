load("@beam_deps//:requirements.bzl", "requirement")

# stolen from apache beam examples
py_binary(
    name = "example_wordcount",
    srcs = ["example_wordcount.py"],
    main = "example_wordcount.py",
    target_compatible_with = ["//python:python3_9"],
    deps = [
        requirement("apache-beam"),
    ],
)

# hello with constraint
py_binary(
    name = "hello_39only",
    srcs = ["hello.py"],
    main = "hello.py",
    target_compatible_with = ["//python:python3_9"],
)

# hello without constraint
py_binary(
    name = "hello",
    srcs = ["hello.py"],
    main = "hello.py",
)
