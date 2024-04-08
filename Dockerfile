FROM haskell:8.6.5
ARG ARCHIVE_NAME=quipper-0.9.0.0

RUN cabal update
RUN cabal install quipper

RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' \
           -e 's|security.debian.org|archive.debian.org/|g' \
           -e '/stretch-updates/d' /etc/apt/sources.list
RUN apt-get update && apt-get install -y gawk

ADD https://www.mathstat.dal.ca/~selinger/quipper/downloads/$ARCHIVE_NAME.tgz /tmp/
RUN tar -C /tmp -xvf /tmp/$ARCHIVE_NAME.tgz \
    && mkdir -p /root/.bin/ \
    && cp -a /tmp/$ARCHIVE_NAME/scripts/quipper /tmp/$ARCHIVE_NAME/scripts/convert_template.sh /tmp/$ARCHIVE_NAME/scripts/convert_template.awk /root/.bin/ \
    && rm -rvf /tmp/$ARCHIVE_NAME

COPY qasm.sh /root/.bin/qasm
COPY quipper-qasm /tmp/quipper-qasm/
WORKDIR /tmp/quipper-qasm/
RUN ghc QasmPrinting \
    && cp ./QasmPrinting /root/.bin/ \
    && rm -rvf /tmp/quipper-qasm

WORKDIR /quipper
ENV PATH /root/.bin:$PATH

