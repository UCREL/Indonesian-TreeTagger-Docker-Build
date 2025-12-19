FROM debian:stable-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    perl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r treetagger && useradd -r --create-home -g treetagger treetagger

USER treetagger
WORKDIR /home/treetagger

RUN wget -O "tree-tagger-linux-3.2.5.tar.gz" "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tree-tagger-linux-3.2.5.tar.gz" \
    && wget -O "tagger-scripts.tar.gz" "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tagger-scripts.tar.gz" \
    && wget -O "install-tagger.sh" "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/install-tagger.sh" \
    && wget -O "indonesian.par.gz" "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/indonesian.par.gz" \
    && sh install-tagger.sh \
    && rm tagger-scripts.tar.gz \
    && rm tree-tagger-linux-3.2.5.tar.gz \
    && rm install-tagger.sh \
    && rm indonesian.par.gz

ENTRYPOINT [ "bash", "cmd/tree-tagger-indonesian" ]
