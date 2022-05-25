load("@rules_python//python/pip_install:requirements.bzl", "compile_pip_requirements")

# Edit requirements.in, update dependencies with:
# bazel run //app:requirements.update
compile_pip_requirements(
    name = "requirements",
    extra_args = [
        "--allow-unsafe",
    ],
)
