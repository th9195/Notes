

### 使用 ffmpeg 将 MP3 转为 PCM

Mac 下安装 ffmpeg：`brew install ffmpeg`

使用 ffmpeg 将 mp3 转换为 pcm：`ffmpeg -i xxx.mp3 -f s16le -ar 44100 -ac 2 -acodec pcm_s16le xxx.pcm`

- -i 制定输入文件
- -f 指定输出编码格式为16byte小端格式
- -ar 指定输出采样率
- -ac 指定输出通道数
- acodec 指定解码格式
- xxx.pcm 为输出文件



### 系统中的所有音频设备文件

aiv8167sm3_bsp:/ # ls -shal /dev/snd

total 0

0 drwxr-xr-x 2 root  root    400 2010-01-01 08:00 .

0 drwxr-xr-x 18 root  root   2.9K 2010-01-01 08:00 ..

0 crw-rw-rw- 1 system audio 116,  2 2010-01-01 08:00 controlC0

0 crw-rw-rw- 1 system audio 116,  3 2010-01-01 08:00 pcmC0D0p

0 crw-rw-rw- 1 system audio 116, 15 2010-01-01 08:00 pcmC0D10c

0 crw-rw-rw- 1 system audio 116, 14 2010-01-01 08:00 pcmC0D10p

0 crw-rw-rw- 1 system audio 116,  4 2010-01-01 08:00 pcmC0D1c

0 crw-rw-rw- 1 system audio 116,  5 2010-01-01 08:00 pcmC0D2c

0 crw-rw-rw- 1 system audio 116,  6 2010-01-01 08:00 pcmC0D3p

0 crw-rw-rw- 1 system audio 116,  7 2010-01-01 08:00 pcmC0D4c

0 crw-rw-rw- 1 system audio 116,  8 2010-01-01 08:00 pcmC0D5p

0 crw-rw-rw- 1 system audio 116,  9 2010-01-01 08:00 pcmC0D6c

0 crw-rw-rw- 1 system audio 116, 10 2010-01-01 08:00 pcmC0D7p

0 crw-rw-rw- 1 system audio 116, 11 2010-01-01 08:00 pcmC0D8c

0 crw-rw-rw- 1 system audio 116, 13 2010-01-01 08:00 pcmC0D9c

0 crw-rw-rw- 1 system audio 116, 12 2010-01-01 08:00 pcmC0D9p

0 crw-rw-rw- 1 system audio 116,  1 2010-01-01 08:00 seq

0 crw-rw-rw- 1 system audio 14,  1 2010-01-01 08:00 sequencer

0 crw-rw-rw- 1 system audio 14,  8 2010-01-01 08:00 sequencer2

0 crw-rw-rw- 1 system audio 116, 33 2010-01-01 08:00 timer

aiv8167sm3_bsp:/ # 



音频设备的命名规则为 [device type]C[card index]D[device index][capture/playback]，即名字中含有4部分的信息：

1. device type
   设备类型，通常只有compr/hw/pcm这3种。从上图可以看到声卡会管理很多设备，PCM设备只是其中的一种设备。
2. card index
   声卡的id，代表第几块声卡。通常都是0，代表第一块声卡。手机上通常都只有一块声卡。
3. device index
   设备的id，代表这个设备是声卡上的第几个设备。设备的ID只和驱动中配置的DAI link的次序有关。如果驱动没有改变，那么这些ID就是固定的。
4. capture/playback
   只有PCM设备才有这部分，只有c和p两种。c代表capture，说明这是一个提供录音的设备，p代表palyback，说明这是一个提供播放的设备。





### 所有的音频设备的信息

/proc/asound/pcm文件

aiv8167sm3_bsp:/ # cat /proc/asound/pcm

00-00: MultiMedia1_PLayback (*) : : playback 1

00-01: MultiMedia_Capture (*) : : capture 1

00-02: MultiMedia1_Capture (*) : : capture 1

00-03: HMDI_PLayback (*) : : playback 1

00-04: DL1_AWB_Record (*) : : capture 1

00-05: MultiMedia2_PLayback (*) : : playback 1

00-06: VOIP_Call_BT_Capture (*) : : capture 1

00-07: MRGRX_PLayback (*) : : playback 1

00-08: MRGRX_CAPTURE (*) : : capture 1

00-09: BTCVSD_Capture snd-soc-dummy-dai-9 : : playback 1 : capture 1

00-10: BTCVSD_Playback snd-soc-dummy-dai-10 : : playback 1 : capture 1

aiv8167sm3_bsp:/ # 