# phycorder_example



Update an existing alignment using a phylogeny from OpenTree:  

Install physcraper.  Use Cleanup branch.  
To use in a virtusl environment:

```
  virtualenv -p python3 venv-physcraper  
  source venv-physcraper/bin/activate  
```

Install physcraper with:
```
   pip install -r requirements.txt  
   pip install -e . #from the physcraper directory
```


opentree_scrape.py -s Study_Id -t Tree_ID -a path_to_alignment -as alignemnt_schema -o output_directory  

e.g.  

opentree_scrape.py -s pg_55 -t tree5864 -a treebase_alns/pg_55tree5864.aln -as "nexus" -o tmp  
