inputs
	NA12878_wgs_20.bai -- the bam index file to correspond to the input bam
	NA12878_wgs_20.bam -- the input bam; data taken from whole-genome-sequenced sample NA12878 of the CEU data set, then subset to chromosome 20

outputs
	NA12878_raw.INDEL.vcf -- the output from the task select as selectIndels
	NA12878_raw.SNP.vcf -- the output from the task select as selectSNPs
	NA12878.raw.indels.snps.vcf -- the output from task haplotypeCaller
	NA12878.rawIndels.table -- the output from selectIndels, converted to table format with all annotations included, for viewing in RStudio

ref
	human_g1k_b37_20.fasta -- the human reference genome, version b37, subset to chromosome 20
	human_g1k_b37_20.dict -- the dictionary to correspond with the above reference sequence file
	human_g1k_b37_20.fasta.fai -- the index file to correspond with the above reference sequence file

simpleVariantSelection.wdl -- the final script that was run