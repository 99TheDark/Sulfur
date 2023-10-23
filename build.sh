#!/bin/bash
go build || exit 1
sh sulfur.sh || exit 1 