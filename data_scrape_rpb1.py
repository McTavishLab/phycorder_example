import sys
import physcraper
from physcraper.opentree_helpers import scraper_from_opentree




configfi = "/home/ejmctavish/projects/otapi/data_physcraper/data.config"
study_id = "pg_238"
tree_id = "tree110"
workdir ="scrape_pg238_rpb1"

aln_fi = "/home/ejmctavish/projects/otapi/data_physcraper/rpb1/physcraper.fas"

conf = physcraper.ConfigObj(configfi)

data_obj = physcraper.generate_ATT_from_phylesystem(alnfile=aln_fi,
                                             aln_schema = "fasta",
                                             workdir=workdir,
                                             configfile=configfi,
                                             study_id=study_id,
                                             tree_id=tree_id,
                                             tip_label='otu')

ids = physcraper.IdDicts(configfi)
scraper = physcraper.PhyscraperScrape(data_obj, ids)

scraper.blast_subdir = "scrape_pg238/current_blast_run"


sys.stdout.write("{} taxa in alignment and tree\n".format(len(scraper.data.aln)))


scraper.read_blast_wrapper()
scraper.est_full_tree()
scraper.data.write_labelled(label='^ot:ottTaxonName')
