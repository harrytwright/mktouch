# mktouch(1)

[![mktouch](https://github.com/harrytwright/mktouch/actions/workflows/mktouch.sh.yml/badge.svg)](https://github.com/harrytwright/mktouch/actions/workflows/mktouch.sh.yml)

This is a utility to allow for creating and populating folders

> This is a little wrapper for `mkdir` & `touch`

## Installing

```shell
$ curl https://raw.githubusercontent.com/harrytwright/mktouch/main/mktouch.sh -o mktouch.sh

$ cp ./mktouch.sh /usr/local/bin/mktouch
```


## Usage

Creating 4 temp dirs and adding an index.sh file inside each

```shell
# command       <dirs>          - <files>
$ ./mktouch.sh ./temp/{1,2,3,4} - index.sh
```

An actual use case, creating the boilerplate for a React component

```shell
$ ./mktouch.sh ./src/components/Input - {index,Wrapper,hooks,reducer,actions}.js

$ ./mktouch.sh ./src/plugins/PluginName - {plugin,installer,builder}.rb
```
