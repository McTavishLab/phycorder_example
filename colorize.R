library(phytools)

#treefile = '/home/ejmctavish/projects/otapi/data_physcraper/data/pg_2827_tree6577/run_pg_2827tree6577_run4/RAxML_bestTree.2020-07-31'
#otu_info_file = '/home/ejmctavish/projects/otapi/data_physcraper/data/pg_2827_tree6577/outputs_pg_2827tree6577/otu_info_pg_2827tree6577.csv'


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


plotBranchbyTrait(pruned, new, mode=c("tips"), show.tip.label = TRUE, palette=colorRampPalette(c("black", "red")), type='fan')

pruned[["tip.label"]] <- spp_labels
names(new) <- pruned[["tip.label"]]
plotBranchbyTrait(pruned, new, mode=c("tips"), legend=FALSE, show.tip.label = TRUE, palette=colorRampPalette(c("black", "red")), cex=0.3, edge.width=0.5)



