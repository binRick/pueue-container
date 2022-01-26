FROM docker.io/fedora:35 as fedora-wgrest-build
RUN dnf -y install cmake make gcc automake autoconf
RUN dnf -y install git golang
RUN git clone https://github.com/binRick/wgrest /usr/src/wgrest
WORKDIR /usr/src/wgrest
RUN rm go.mod go.sum
RUN go mod init wgrest
RUN go mod tidy
RUN go get
RUN go build

FROM docker.io/fedora:35 as fedora-wgrest

#COPY --from=fedora-wgrest-build /usr/bin/wgrest /usr/bin/wgrest
