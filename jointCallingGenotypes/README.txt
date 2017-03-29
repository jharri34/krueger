inputs
	inputsTSV.txt -- a tab separated value file which specifies the absolute paths of each input sample.
	NA12877_wgs_20.bai -- the bam index file to correspond to the input bam
	NA12877_wgs_20.bam -- the input bam; data taken from whole-genome-sequenced sample NA12877 of the CEU data set, then subset to chromosome 20
	NA12878_wgs_20.bai -- the bam index file to correspond to the input bam
	NA12878_wgs_20.bam -- the input bam; data taken from whole-genome-sequenced sample NA12878 of the CEU data set, then subset to chromosome 20
	NA12882_wgs_20.bai -- the bam index file to correspond to the input bam
	NA12882_wgs_20.bam -- the input bam; data taken from whole-genome-sequenced sample NA12878 of the CEU data set, then subset to chromosome 20

outputs
	CEUtrio_rawVariants.vcf -- the final vcf output from GenotypeGVCFs
	CEUtrio_rawVariants.vcf.idx -- the index to correspond to the above vcc  
	

ref
	human_g1k_b37_20.fasta -- the human reference genome, version b37, subset to chromosome 20
	human_g1k_b37_20.dict -- the dictionary to correspond with the above reference sequence file
	human_g1k_b37_20.fasta.fai -- the index file to correspond with the above reference sequence file

jointCallingGenotypes.wdl -- the final script that was run