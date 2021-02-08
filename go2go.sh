#!/usr/bin/env zsh
set -e
GO2PATH=~/code/oss/go2/src/cmd/go2go/testdata/go2path \
GOROOT=~/code/oss/go2 \
~/code/oss/go2/bin/go tool go2go $@
