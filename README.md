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

```
  -s STUDY_ID, --study_id STUDY_ID  
                        OpenTree study id  
  -t TREE_ID, --tree_id TREE_ID  

  -a ALIGNMENT, --alignment ALIGNMENT  
                        path to alignment  
  -as ALN_SCHEMA, --aln_schema ALN_SCHEMA  
                        alignment schema (nexus or fasta)  
  -db BLAST_DB, --blast_db BLAST_DB  
                        local download of blast database  
  -o OUTPUT, --output OUTPUT  
                        path to output directory  
  -c CONFIG_FILE, --config_file CONFIG_FILE  
                        path to config file  
  -tb, --treebase       download alignment from treebase  
```


The simplest (but slowest) run is to choose a tree from opentree, and `physcraper` gets the alignment for you from treebase (argument `-tb`), using web blast:  

    physcraper_run.py -s pg_55 -t tree5864 -tb -o output_pg55_treebase 


The fastest run is to choose a tree from opentree, give the path to the corresponding downloaded alignment (argument `-a`) and a local blast directory (argument `-db`):  

    physcraper_run.py -s pg_55 -t tree5864 -a treebase_alns/pg_55tree5864.aln -as "nexus" -db ~/ncbi/localblastdb/ -o output_pg55_local


To check tree download and the matching of names across tree and alignment without running the blast and tree estimation steps, use the flag (-no_est):  
  
    physcraper_run.pys ot_1919 -t Tr115925 --treebase -db ~/ncbi/localblastdb/ -no_est -o output_test

  Take a look at the tree, teh alignemnt and the out_info csv file. It will list all taxa by their unique idetifiers.


To then run a blast search and estimate an updated tree from that tree and alignemnt, you can re-load from that directory. It will sue your same config settings (which weere automatically written out to outputdir/run.config)

    physcraper_run.py -re output_test/ -o output_test


To re-run with a different configuration file, 

    physcraper_run.py -re output_test/ -c alt_config -o output_test




