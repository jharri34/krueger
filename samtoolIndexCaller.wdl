workflow samtoolIndex {
File inputSamplesFile
   Array[Array[File]] inputSamples = read_tsv(inputSamplesFile)
   File samtool

   scatter (sample in inputSamples) {
     call SamToolCaller {
       input: bamFile=sample[1],
         sampleName=sample[0],
      }
   }
}
task SamToolCaller {
  String sampleName
  File bamFile
  File samtool

  command {
    java -jar ${samtool} \
        index -b \
        ${bamFile} \
        -o ${sampleName}.bai
  }
  output {
    File BAI = "${sampleName}.bai"
  }
}
