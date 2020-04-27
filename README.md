# phycorder_example



Update an existing alignment using a phylogeny from OpenTree:  

Install physcraper.  

opentree_scrape.py -s Study_Id -t Tree_ID -a path_to_alignment -as alignemnt_schema -o output_directory  

e.g.  

opentree_scrape.py -s pg_55 -t tree5864 -a treebase_alns/pg_55tree5864.aln -as "nexus" -o tmp  
