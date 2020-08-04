library(phytools)

## set working directory to path to https://github.com/McTavishLab/physcraper_example
setwd("~/projects/otapi/data_physcraper")

#treefile = 'data/pg_2827_tree6577/run_pg_2827tree6577_run4/RAxML_bestTree.2020-07-31'
#otu_info_file = 'data/pg_2827_tree6577/outputs_pg_2827tree6577/otu_info_pg_2827tree6577.csv'

#treefile = 'pg_55_local_new/outputs_pg_55tree5864_ndhf/physcraper_pg_55tree5864_ndhf.tre'
#otu_info_file = 'pg_55_local_new/outputs_pg_55tree5864_ndhf/otu_info_pg_55tree5864_ndhf.csv'


#treefile = 'ot_350/outputs_ot_350Tr53297/physcraper_ot_350Tr53297.tre'
#otu_info_file = 'ot_350/outputs_ot_350Tr53297/otu_info_ot_350Tr53297.csv'


treefile = 'pg127/outputs_pg_127tree804/physcraper_pg_127tree804.tre'
otu_info_file = 'pg127/outputs_pg_127tree804/otu_info_pg_127tree804.csv'


phytree = read.tree(treefile)


tip_info = read.csv(otu_info_file, sep = '\t', row.names = 1, stringsAsFactors = FALSE)

inout <- as.vector(tip_info$X.physcraper.ingroup)
names(inout) <- rownames(tip_info)
  
outgroups = c()
for (lab in phytree[["tip.label"]]) {
  status = inout[names(inout) == lab]
  if (status == "False")
  {outgroups = c(outgroups, lab)}
}

pruned <- drop.tip(phytree,phytree$tip.label[match(outgroups, phytree$tip.label)])

st <- as.vector(tip_info$X.physcraper.status)
names(st) <- rownames(tip_info)

spp <- as.vector(tip_info$X.ot.ottTaxonName)
names(spp) <- rownames(tip_info)


new = c()
spp_labels = c()
for (lab in pruned[["tip.label"]]) {
  status = st[names(st) == lab]
  val = grepl("new", status, fixed = TRUE)
  val = 100*as.integer(val)
  names(val) <- lab
  new = c(new, val)
  tax = spp[names(spp) == lab]
  spp_labels = c(spp_labels, tax)
}


plotBranchbyTrait(pruned, new, mode=c("tips"),legend=FALSE, show.tip.label = FALSE, palette=colorRampPalette(c("black", "red")), type='fan')

pruned[["tip.label"]] <- spp_labels
names(new) <- pruned[["tip.label"]]
plotBranchbyTrait(pruned, new, mode=c("tips"), legend=FALSE, show.tip.label = FALSE, palette=colorRampPalette(c("black", "red")), cex=0.5, edge.width=3, type='unrooted')



