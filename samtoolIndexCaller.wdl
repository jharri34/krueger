workflow samtoolIndex {
   Array[File] inputSamples = read tsv(inputSamplesFile)
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

  command {
    java -jar ${samtool} \
        index -b \
        ${bamFile} \
        -o ${samapleName}.bai
  }
  output {
    File BAI = "${sampleName}.bai"
  }
}
