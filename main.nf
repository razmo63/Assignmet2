#!/usr/bin/env nexflow

params.cutoff=10
process filtseq{
  input:
    path Datafile
    val cutoff

  output:
    path 'output.txt'

script:
"""
#!/usr/bin/env python3
from Bio import SeqIO
for seq_record in SeqIO.parse("$Datafile","fasta"):
        if len(seq_record)>$cutoff:
                with open("output.txt","a") as f:
                        f.write(str(seq_record.description)+ '\\n'+ str(seq_record.seq)+ '\\n')
"""
}

workflow {
   inputFile = Channel.fromPath(params.input)
   filtseq(inputFile,params.cutoff)
}

