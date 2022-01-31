# Indonesian-TreeTagger-Docker-Build

Docker file to build the [TreeTagger](https://www.cis.lmu.de/~schmid/tools/TreeTagger/) specifically for Indonesian.

## License

The contents of this repository is licensed under Apache License Version 2.0 as stated within the [LICENSE file](./LICENSE). **HOWEVER** by building this [Docker file](./dockerfile) you are implicitly agreeing to the [TreeTagger license](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/Tagger-Licence) as you are downloading and using the TreeTagger code when building and running this docker container. Part of the TreeTagger license stops you from re-distributing the TreeTagger code, therefore please do not upload your built docker container to a registry like [Docker Hub](https://hub.docker.com/).

## Build the docker container

The easiest way to do this is to run the following (docker container size roughly 139MB):

``` bash
docker build -t indonesian-treetagger:1.0.0 https://github.com/UCREL/Indonesian-TreeTagger-Docker-Build.git#main
```

## Run the docker container

We are assuming you have built the docker container and tagged it as `indonesian-treetagger:1.0.0`.

### Tagging to stdout

``` bash
echo "Dia adalah abdi negara" | docker run --rm -i indonesian-treetagger:1.0.0
```

Output should be:

``` bash
        reading parameters ...
        tagging ...
         finished.
Dia     PRP     dia
adalah  VB      adalah
abdi negara     NN      abdi negara
```

### Tagging and outputting to a TSV file

``` bash
echo "Dia adalah abdi negara" | docker run --rm -i indonesian-treetagger:1.0.0 > output_file.tsv
```

The TSV file should contain (**Note** we have added column headers here to explain what each column represents, these headers should not be in your file):

``` bash
token	POS	lemma
Dia	PRP	dia
adalah	VB	adalah
abdi negara	NN	abdi negara
```

POS = Part Of Speech

## Indonesian Tagger details

The tagger has been built to handle both abbreviations and Multi Word Units (MWU), a good example of a MWU is `abdi negara`.

The tagger uses the UI POS tagset, which can be found [here.](https://drive.google.com/file/d/1Pnhj2vVEEP5eIc655Af-WPDXxthyZdwb/view)

The Indonesian TreeTagger was trained by by [Prihantoro](https://sites.google.com/live.undip.ac.id/prihantoro/home) on the [idn-tagged-corpus](https://github.com/famrashel/idn-tagged-corpus) using an additional lexicon that was created in two parts:
1. Data from the [idn-tagged-corpus](https://github.com/famrashel/idn-tagged-corpus) was used to create a lexicon, this corpus data was first lemmatised using [MorphInd](https://septinalarasati.com/morphind/) before being added to the lexicon.
2. Simplex and Compound words from [Kateglo](https://datahub.io/aps2201/kateglo_scrape#resource-kateglo_scrape_zip), of which the POS tagset used in Kateglo differed therefore it was mapped to the UI POS tagset.

The abbreviations and MWU lexicon data was created by [Prihantoro](https://sites.google.com/live.undip.ac.id/prihantoro/home) and can be found within the [TreeTagger software.](https://www.cis.lmu.de/~schmid/tools/TreeTagger/)

## Acknowledgements

We thank: 

* [Helmut Schmid](https://www.cis.uni-muenchen.de/~schmid/) for creating and releasing the [TreeTagger software](https://www.cis.lmu.de/~schmid/tools/TreeTagger/).
* [Prihantoro](https://sites.google.com/live.undip.ac.id/prihantoro/home) for creating the Indonesian resources for TreeTagger as well as guiding us through how to use the Indonesian TreeTagger.
