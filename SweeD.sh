#!/bin/bash

# Define variables
pop=Pop1.txt
tempF=p1.vcf
vcfF=Data.vcf

# Load necessary modules
module load bioinfo/tabix-0.2.5
module load bioinfo/vcftools-0.1.15

# Extract the header from the VCF file to keep it unchanged with grep and select samples (pop)
zcat $vcfF | head -n 1000 | vcftools --vcf - --keep $pop --recode | grep '#' > $tempF

# Filter SNPs by removing indels and missing data, and keeping the specified individuals
vcftools --gzvcf $vcfF --keep $pop -c --recode | grep -v '*' | grep -Pv '\t\.:' | grep -v '#' >> $tempF

# Run SweeD on the filtered VCF file
SweeD-P -name DATA_SweeD -input $tempF -grid 1000 -threads 10

