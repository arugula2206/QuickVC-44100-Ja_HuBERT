# CUDA環境を含むベースイメージを指定
FROM nvidia/cuda:12.4.0-devel-ubuntu20.04

# 作業ディレクトリを設定
WORKDIR /app

# タイムゾーンの設定ファイルにシンボリックリンクを強制的に上書き作成
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# 必要なシステム依存パッケージのインストール（Python 3.9とその他必要なパッケージ）
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    tzdata \
    pulseaudio \
    python3.9 \
    python3.9-dev \
    python3.9-distutils &&\
    apt-get clean

# リポジトリのコードをコピー
COPY . /app

# Python 3.9のpipをインストール
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.9 get-pip.py && \
    rm get-pip.py

# Pythonのパッケージインストール
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install torch torchvision torchaudio

# コンテナ起動後に実行するコマンド
CMD ["bash"]

