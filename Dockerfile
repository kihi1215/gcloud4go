FROM kihi1215/gcloud

LABEL maintainer="kihi"

ARG GO_TAR_GZ="go1.15.5.linux-amd64.tar.gz"
ARG BASH_PROMPT="'\[\033[33m\]\n[\! \t \u@\h \w]\n\\$ \[\033[37m\]'"
ARG EXPOSE_PORT="80"

ENV TZ="Asia/Tokyo" \
    PORT=${EXPOSE_PORT} \
    PATH="/go/bin:/usr/local/go/bin:${PATH}"

RUN curl -LO https://golang.org/dl/${GO_TAR_GZ}
RUN tar xvf ${GO_TAR_GZ} -C /usr/local
RUN rm ${GO_TAR_GZ}

RUN mkdir /go

RUN go env -w GO111MODULE=on \
 && go env -w CGO_ENABLED=0 \
 && go env -w GOMODCACHE=/go/pkg/mod \
 && go env -w GOPATH=/go

RUN go get -v github.com/go-delve/delve/cmd/dlv

RUN ["bash", "-c", "echo export PS1=$BASH_PROMPT >> /root/.bashrc"]

EXPOSE ${EXPOSE_PORT}

WORKDIR /go

CMD ["/bin/bash"]
