This is a Docker image for [Quipper][1], a quantum programming
language embedded in Haskell.

Getting Started
===============

To use this:

    $ git submodule update --
    $ docker build -t ausbin/docquipper .
    $ docker run --rm -v $(pwd):/quipper ausbin/docquipper quipper bv.hs
    $ ./bv

To convert bv.hs to bv.qasm (credits to onestruggler) use:

    $ docker run -it --rm -v $(pwd):/quipper ausbin/docquipper qasm bv.hs

Link to onestruggler's og repo:
https://github.com/onestruggler/quipper-qasm.git

(If you're not on amd64 Linux, that last command should probably be in
the Docker container instead.)

Examples
========

The example programs in `examples/` are reconstructed from ["Five Quantum
Algorithms Using Quipper" by Siddiqui, Islam, and Shehab (2014)][4].

Hacks
=====

Quipper appears to be dependent on an older version of Haskell and
Debian, so the image pulls in an older (compatible) version of [the
`haskell` image][3]. This image is based on an unsupported version of
Debian, so the Dockerfile updates `/etc/apt/sources.list` to use
`archive.debian.org`.

There is a bug of some kind with [`quipper-pp.hs`][2] (the Quipper
preprocessor) in which Haskell is SIGTERMing awk, causing awk to fail.
I have not investigated the issue beyond an strace session revealing
the SIGTERM along with many single-byte `write()`s (functional
programming elegance?), but I did find that `quipper-pp.hs` seems to
replace `convert_template.sh`, a shell script in the "legacy" (tarball)
distribution of Quipper. So the `Dockerfile` substitutes the Haskell
`quipper` binary shipped with the cabal package with the original
`quipper` shell script (also in the "legacy" distribution), which calls
`convert_template.sh`.

[1]: https://www.mathstat.dal.ca/~selinger/quipper/
[2]: https://hackage.haskell.org/package/quipper-language-0.9.0.0/src/programs/quipper-pp.hs
[3]: https://hub.docker.com/_/haskell/
[4]: https://arxiv.org/abs/1406.4481
