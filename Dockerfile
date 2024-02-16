FROM haskell:8.6.5
MAINTAINER Austin Adams <aja@gatech.edu>
#RUN cabal update && cabal install QuickCheck random mtl primes Lattices zlib easyrender fixedprec newsynth containers set-monad
RUN cabal update
RUN cabal install quipper

RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' \
           -e 's|security.debian.org|archive.debian.org/|g' \
           -e '/stretch-updates/d' /etc/apt/sources.list
RUN apt-get update && apt-get install -y gawk
#
#WORKDIR /
#ADD http://www.mathstat.dal.ca/~selinger/quipper/downloads/quipper-0.7.tgz /
#RUN tar xf quipper-0.7.tgz
#RUN mv quipper-0.7 quipper
#
#WORKDIR /quipper
#RUN make
#ENV PATH /quipper/quipper/scripts:$PATH
ENV PATH /root/.cabal/share/x86_64-linux-ghc-8.6.5/quipper-language-0.9.0.0/scripts:$PATH
CMD ['quipper']
