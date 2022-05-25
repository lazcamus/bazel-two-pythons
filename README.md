# bazel multiple python toolchains

This repo has an example of using multiple python versions side by side by
using platforms+toolchains.

I have a repository that uses python 3.10.2 but there's desire to support
Apache Beam, which currently only supports up to python 3.9. We'd like to
selectively enable python3.9 on only some targets.

## Toolchain & Platform & Constraint Config

In `WORKSPACE` I'm using `python_register_toolchains` to use the prebuilt python
binaries. To get multiple versions of the python toolchain to co-exist and
be selectable with a constraint, **you must pass `register_toolchains = False`**
to avoid having it automatically register the toolchains.

Then in `python/BUILD` toolchains are generated which point to the downloaded
python releases with an additional `python_language_version` constraint.

Finally, we register these toolchains and platforms in `WORKSPACE` with:
```
register_toolchains("//python:all")
register_execution_platforms("//python:all")
```

The generated rules look like this:
```sh
$ bazel query //python/... --output=label_kind
platform rule //python:linux_aarch64_python3_10
platform rule //python:linux_aarch64_python3_9
platform rule //python:linux_x86_64_python3_10
platform rule //python:linux_x86_64_python3_9
platform rule //python:local_host_python3_10
platform rule //python:local_host_python3_9
constraint_value rule //python:python3_10
toolchain rule //python:python3_10_toolchain_aarch64
toolchain rule //python:python3_10_toolchain_x86_64
constraint_value rule //python:python3_9
toolchain rule //python:python3_9_toolchain_aarch64
toolchain rule //python:python3_9_toolchain_x86_64
constraint_setting rule //python:python_lang_version
```

## Using it

The python version used for a target can be selected by passing the
`--platforms` flag like so:

```sh
$ bazel run --platforms=//python:linux_aarch64_python3_10  //app:hello
Hello from python 3.10.2 (main, Feb 27 2022, 20:10:03) [GCC 6.3.0 20170516]

$ bazel run --platforms=//python:linux_aarch64_python3_9 //app:hello
Hello from python 3.9.10 (main, Feb 27 2022, 19:47:43) 
[GCC 6.3.0 20170516]

$ bazel run //app:hello
Hello from python 3.10.2 (main, Feb 27 2022, 20:10:03) [GCC 6.3.0 20170516]
```

It appears that the last python toolchain (with version constraint) registered
matches when using the host execution environment? So I guess order is significant.

If you have a rule that should only be run on one version of python, you can add a constraint:
```python
py_binary(
    name = "hello_39only",
    srcs = ["hello.py"],
    main = "hello.py",
    target_compatible_with = ["//python:python3_9"],
)
```

This target won't run unless you pass the right `--platforms` flag:
```shell
$ bazel run --platforms=//python:linux_aarch64_python3_9 //app:hello_39only  
Hello from python 3.9.10 (main, Feb 27 2022, 19:47:43) 
[GCC 6.3.0 20170516]

$ bazel run --platforms=//python:linux_aarch64_python3_10 //app:hello_39only 
ERROR: Target //app:hello_39only is incompatible and cannot be built, but was explicitly requested.
Dependency chain:
    //app:hello_39only   <-- target platform (//python:linux_aarch64_python3_10) didn't satisfy constraint //python:python3_9
ERROR: Build failed. Not running target

$ bazel run //app:hello_39only
ERROR: Target //app:hello_39only is incompatible and cannot be built, but was explicitly requested.
Dependency chain:
    //app:hello_39only   <-- target platform (@local_config_platform//:host) didn't satisfy constraint //python:python3_9
ERROR: Build failed. Not running target
```
