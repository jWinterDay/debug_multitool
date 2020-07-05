#!/bin/bash

flutter packages pub run build_runner build

killall -9 dart