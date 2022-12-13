#!/bin/sh

dotnet publish Jellyfin.Server --configuration Release --self-contained --runtime linux-x64 --output /home/programs/jellyfin/ "-p:DebugSymbols=false;DebugType=none;UseAppHost=true"	
