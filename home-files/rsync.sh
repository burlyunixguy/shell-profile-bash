#!/usr/bin/env bash
rsync -arv --delete $(dirname $0)/.bash* $(dirname $0)/.zsh* $(dirname)/.oh-my-zsh/custom $(dirname $0)/.zlogout ~/
