load("@beam_deps//:requirements.bzl", "requirement")

# stolen from apache beam examples
py_binary(
    name = "example_wordcount",
    srcs = ["example_wordcount.py"],
    exec_compatible_with = ["//beam:python3_9"],
    main = "example_wordcount.py",
    deps = [
        requirement("apache-beam"),
    ],
)

# hello with constraint
py_binary(
    name = "hello",
    srcs = ["hello.py"],
    exec_compatible_with = ["//beam:python3_9"],
    main = "hello.py",
)

# hello without constraint
py_binary(
    name = "hello_nocompat",
    srcs = ["hello.py"],
    main = "hello.py",
)
