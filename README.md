# Physcraper Run Example



Update an existing alignment using a phylogeny from OpenTree:  

Install physcraper.  Use Cleanup branch. 

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

You can run analyses using   
    physcraper_run.py with the following possible arguments.



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



The simplest (but slowest) 


To get an alignment from treebase, for a tree from opentree, using web blast:  
physcraper_run.py -s pg_55 -t tree5864 -tb -o tmp  


To update a downlodad alignment and estimate a tree, for a tree from opentree, using a local blast directory:  

physcraper_run.py -s pg_55 -t tree5864 -a treebase_alns/pg_55tree5864.aln -as "nexus" -db ~/ncbi/localblastdb_meta/ -o tmp   
