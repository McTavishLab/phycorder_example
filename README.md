# Physcraper Run Example



Update an existing alignment using a phylogeny from OpenTree:  

Install physcraper.  

To use in a virtual environment:

```
  virtualenv -p python3 venv-physcraper  
  source venv-physcraper/bin/activate  
```

Install physcraper with:
```
   pip install -r requirements.txt  
   pip install -e . #from the physcraper directory
```

You can run analyses using `physcraper_run.py` with the following possible arguments.

To see all the arguments use  physcraper_run.py --help
```
  usage: physcraper_run.py [-h] [-s STUDY_ID] [-t TREE_ID] [-tl TREE_LINK]
                         [-a ALIGNMENT] [-as ALN_SCHEMA] [-db BLAST_DB]
                         [-o OUTPUT] [-tx TAXONOMY] [-c CONFIGFILE] [-e EMAIL]
                         [-re RELOAD_FILES] [-tag TAG] [-tb] [-no_est]
                         [-ev EVAL] [-hl HITLIST_LEN] [-tp TRIM_PERC]
                         [-rl RELATIVE_LENGTH] [-spn SPECIES_NUMBER]
                         [-nt NUM_THREADS] [-de DELAY]

optional arguments:
  -h, --help            show this help message and exit
  -s STUDY_ID, --study_id STUDY_ID
                        OpenTree study id
  -t TREE_ID, --tree_id TREE_ID
                        OpenTree tree id
  -tl TREE_LINK, --tree_link TREE_LINK
                        Link to tree to update on OpenTree
  -a ALIGNMENT, --alignment ALIGNMENT
                        path to alignment
  -as ALN_SCHEMA, --aln_schema ALN_SCHEMA
                        alignment schema (nexus or fasta)
  -db BLAST_DB, --blast_db BLAST_DB
                        local download of blast database
  -o OUTPUT, --output OUTPUT
                        path to output directory
  -tx TAXONOMY, --taxonomy TAXONOMY
                        path to taxonomy
  -c CONFIGFILE, --configfile CONFIGFILE
                        path to config file
  -e EMAIL, --email EMAIL
                        email address for ncbi balst searches
  -re RELOAD_FILES, --reload_files RELOAD_FILES
                        reload files and configureation from dir
  -tag TAG, --tag TAG   gene name or other specifier
  -tb, --treebase       download alignment from treebase
  -no_est, --no_estimate_tree
                        run blast search and estimate tree
  -ev EVAL, --eval EVAL
                        blast evalue cutoff
  -hl HITLIST_LEN, --hitlist_len HITLIST_LEN
                        number of blast searches to save per taxon
  -tp TRIM_PERC, --trim_perc TRIM_PERC
                        minimum percentage of seqs end of alignemnts
  -rl RELATIVE_LENGTH, --relative_length RELATIVE_LENGTH
                        max relative length of added seqs, compared to input
                        aln len
  -spn SPECIES_NUMBER, --species_number SPECIES_NUMBER
                        max number of seqs to include per species
  -nt NUM_THREADS, --num_threads NUM_THREADS
                        number of threads to use in processing
  -de DELAY, --delay DELAY
                        how long to wait before blasting the same sequence
                        again
  -st SEARCH_TAXON, --search_taxon SEARCH_TAXON
                        taxonomic id to constrain blast search. format ott:123
                        or ncbi:123. Deafult will use ingroup of tree on
                        OpenTree, or MRCA of input tips

```


The simplest (but slowest) run is to choose a tree from opentree, and `physcraper` gets the alignment for you from treebase (argument `-tb`), using web blast:  

    physcraper_run.py -s pg_55 -t tree5864 -tb -o output_pg55_treebase 


The fastest run is to choose a tree from opentree, give the path to the corresponding downloaded alignment (argument `-a`) and a local blast directory (argument `-db`):  

    physcraper_run.py -s pg_55 -t tree5864 -a treebase_alns/pg_55tree5864_ndhf.aln -as "nexus" -db ~/ncbi/localblastdb/ -o output_pg55_local


To check tree download and the matching of names across tree and alignment without running the blast and tree estimation steps, use the flag (-no_est):  
  
    physcraper_run.pys ot_1919 -t Tr115925 --treebase -db ~/ncbi/localblastdb/ -no_est -o output_test

  Take a look at the tree, teh alignemnt and the out_info csv file. It will list all taxa by their unique idetifiers.


To then run a blast search and estimate an updated tree from that tree and alignemnt, you can re-load from that directory. It will sue your same config settings (which weere automatically written out to outputdir/run.config)

    physcraper_run.py -re output_test/ -o output_test


To re-run with a different configuration file, 

    physcraper_run.py -re output_test/ -c alt_config -o output_test



Configuration parameters can be either set in a cofniguration file using -c (e.g. data.config)

  physcraper_run.py -s pg_55 -t tree5864 -a treebase_alns/pg_55tree5864_ndhf.aln -nt 8 -spn 3 -hl 20 -as "nexus" -c data.config -o output4


Or they can be modified in the command line arguments. If you combine a configuration file with command line configuration paratemeters, the command line arguments will be used.

  physcraper_run.py -s pg_55 -t tree5864 -a treebase_alns/pg_55tree5864_ndhf.aln -nt 8 -spn 3 -hl 20 -as "nexus" -db ~/ncbi/localblastdb/ -o output4


The current copnfiguration settings are written to standard out, and saved in the output directory as run.config

[blast]
Entrez.email = None
e_value_thresh = 1e-05
hitlist_size = 20
location = local
localblastdb = /home/ejmctavish/ncbi/localblastdb/
url_base = None
num_threads = 8
delay = 90
[physcraper]
spp_threshold = 3
seq_len_perc = 0.8
trim_perc = 0.8
max_len = 1.2
taxonomy_path = /home/ejmctavish/projects/otapi/physcraper/taxonomy
