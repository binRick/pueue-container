FROM alpine:3.14 as alpine-wgrest-build
RUN apk add go make git
RUN git clone https://github.com/binRick/wgrest /usr/src/wgrest
WORKDIR /usr/src/wgrest
RUN rm go.mod go.sum
RUN go mod init wgrest
RUN go mod tidy
RUN go get
RUN go build

RUN cp wgrest /usr/bin/wgrest

FROM alpine:3.14 as alpine-wgrest
COPY --from=alpine-wgrest-build /usr/bin/wgrest /usr/bin/wgrest

