import sys
import physcraper
from physcraper.opentree_helpers import scraper_from_opentree




study_id = "pg_2203"
tree_id = "tree4664"
workdir ="scrape"

aln_fi = "../treebase_alns/pg_2203tree4664.aln"


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