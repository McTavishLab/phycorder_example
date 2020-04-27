import sys
import physcraper
from physcraper.opentree_helpers import scraper_from_opentree




configfi = "/home/ejmctavish/projects/otapi/data_physcraper/data.config"
study_id = "pg_1711"
tree_id = "tree3450"
workdir ="scrape_pg1711_tree3450"

aln_fi = "../treebase_alns/pg_1711tree3450.aln"


# Create an 'scraper' object to get data from NCBI, align it an
scraper = scraper_from_opentree(study_id = study_id, 
                                tree_id = tree_id, 
                                alnfile = aln_fi, 
                                aln_schema = "nexus", 
                                workdir = workdir)

sys.stdout.write("{} taxa in alignment and tree\n".format(len(scraper.data.aln)))


#scraper.read_blast_wrapper()
scraper.est_full_tree()
scraper.data.write_labelled(label='^ot:ottTaxonName')