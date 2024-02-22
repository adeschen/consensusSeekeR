#' consensusSeekeR: Detection of consensus peak regions inside a group of
#' experiments using narrowPeak files
#'
#' This package compares positions and ranges data from multiple experiments
#' to extract common consensus regions. The size of the analyzed region is
#' adjustable as well as the number of experiments in which a peak must be
#' detected to mark a potential region as a consensus peak region.
#'
#' @docType package
#'
#' @name consensusSeekeR-package
#'
#' @aliases consensusSeekeR-package consensusSeekeR
#'
#' @author  Astrid Deschênes,
#' Fabien Claude Lamaze,
#' Pascal Belleau and
#' Arnaud Droit
#'
#' Maintainer:
#' Astrid Deschênes <adeschen@hotmail.com>
#'
#' @seealso
#' \itemize{
#' \item \code{\link{readNarrowPeakFile}} {for extracting regions and peaks
#' from a narrowPeak file.}
#' \item \code{\link{findConsensusPeakRegions}} { for extracting regions
#' sharing the same features in more than one experiment. }
#' }
#'
#' @encoding UTF-8
#' @keywords package
NULL

#' Genomic regions with the greatest evidence of transcription factor binding
#' for the FOSL2 transcription factor (for demonstration purpose)
#'
#' Genomic regions representing the greatest evidence of enrichment for
#' the FOSL2 transcription factor (DCC accession: ENCFF000MZT)
#' for regions chr1:249120200-249250621 and chr10:1-370100
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' @name A549_FOSL2_01_NarrowPeaks_partial
#'
#' @docType data
#'
#' @aliases A549_FOSL2_01_NarrowPeaks_partial
#'
#' @format A \code{GRanges} containing one entry per genomic regions. Each row
#' of \code{GRanges} has a name which represent the name of the experiment.
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF000MZT)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_FOSL2_01_Peaks_partial}} { the associate
#' sites dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#'
#' @usage data(A549_FOSL2_01_NarrowPeaks_partial)
#'
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_FOSL2_01_NarrowPeaks_partial)
#' data(A549_FOSL2_01_Peaks_partial)
#' data(A549_FOXA1_01_NarrowPeaks_partial)
#' data(A549_FOXA1_01_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_FOXA1_01_Peaks_partial) <- rep("FOXA1_01",
#'                             length(A549_FOXA1_01_Peaks_partial))
#' names(A549_FOXA1_01_NarrowPeaks_partial) <- rep("FOXA1_01",
#'                             length(A549_FOXA1_01_NarrowPeaks_partial))
#' names(A549_FOSL2_01_Peaks_partial) <-rep("FOSL2_01",
#'                             length(A549_FOSL2_01_Peaks_partial))
#' names(A549_FOSL2_01_NarrowPeaks_partial) <- rep("FOSL2_01",
#'                             length(A549_FOSL2_01_NarrowPeaks_partial))
#'
#' ## Calculating consensus regions for chromosome 10 only
#' ## with a default region size of 200 bp (2 * extendingSize)
#' ## which is not extended to include all genomic regions.
#' ## A peak from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo("chr10", 135534747, NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_FOXA1_01_NarrowPeaks_partial,
#'                             A549_FOSL2_01_NarrowPeaks_partial),
#'     peaks = c(A549_FOXA1_01_Peaks_partial,
#'                             A549_FOSL2_01_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 100,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = TRUE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL

#' Sites with the greatest evidence of transcription factor binding
#' for the FOSL2 transcription factor (for demonstration purpose)
#'
#' Sites representing the greatest evidence of enrichment for
#' the FOSL2 transcription factor (DCC accession: ENCFF000MZT)
#' for regions chr1:249120200-249250621 and chr10:1-370100
#' from the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' @name A549_FOSL2_01_Peaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site. Each row
#' of \code{GRanges} has the same row name which represent the name
#' of the experiment.
#'
#' @usage data(A549_FOSL2_01_Peaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF000MZT)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_FOSL2_01_NarrowPeaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_FOSL2_01_NarrowPeaks_partial)
#' data(A549_FOXA1_01_NarrowPeaks_partial)
#' data(A549_FOSL2_01_Peaks_partial)
#' data(A549_FOXA1_01_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_FOXA1_01_Peaks_partial) <- rep("FOXA1_01",
#'                             length(A549_FOXA1_01_Peaks_partial))
#' names(A549_FOXA1_01_NarrowPeaks_partial) <- rep("FOXA1_01",
#'                             length(A549_FOXA1_01_NarrowPeaks_partial))
#' names(A549_FOSL2_01_Peaks_partial) <-rep("FOSL2_01",
#'                             length(A549_FOSL2_01_Peaks_partial))
#' names(A549_FOSL2_01_NarrowPeaks_partial) <- rep("FOSL2_01",
#'                             length(A549_FOSL2_01_NarrowPeaks_partial))
#'
#' ## Calculating consensus regions for chromosome 1 only
#' ## with a default region size of 400 bp (2 * extendingSize)
#' ## which is extended to include all genomic regions of the
#' ## closest peak (for each experiment).
#' ## A peak from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo("chr1", 249250621, NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_FOXA1_01_NarrowPeaks_partial,
#'                             A549_FOSL2_01_NarrowPeaks_partial),
#'     peaks = c(A549_FOXA1_01_Peaks_partial,
#'                             A549_FOSL2_01_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 200,
#'     expandToFitPeakRegion = TRUE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL

#' Genomic regions with the greatest evidence of transcription factor binding
#' for the FOXA1 transcription factor (for demonstration purpose)
#'
#' Genomic regions representing the greatest evidence of enrichment for
#' the FOXA1 transcription factor (DCC accession: ENCFF000NAH)
#' for regions chr1:249120200-249250621 and chr10:1-370100
#' from the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' @name A549_FOXA1_01_NarrowPeaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per genomic regions. Each row
#' of \code{GRanges} has a name which represent the name of the experiment.
#'
#' @usage data(A549_FOXA1_01_NarrowPeaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF000NAH)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_FOXA1_01_Peaks_partial}} { the associate
#' sites dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#'
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_FOSL2_01_NarrowPeaks_partial)
#' data(A549_FOSL2_01_Peaks_partial)
#' data(A549_FOXA1_01_NarrowPeaks_partial)
#' data(A549_FOXA1_01_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_FOXA1_01_Peaks_partial) <- rep("FOXA1_01",
#'         length(A549_FOXA1_01_Peaks_partial))
#' names(A549_FOXA1_01_NarrowPeaks_partial) <- rep("FOXA1_01",
#'         length(A549_FOXA1_01_NarrowPeaks_partial))
#' names(A549_FOSL2_01_Peaks_partial) <-rep("FOSL2_01",
#'         length(A549_FOSL2_01_Peaks_partial))
#' names(A549_FOSL2_01_NarrowPeaks_partial) <- rep("FOSL2_01",
#'         length(A549_FOSL2_01_NarrowPeaks_partial))
#'
#' ## Calculating consensus regions for both chromosomes 1 and 10
#' ## with a default region size of 300 bp (2 * extendingSize)
#' ## which is not extended to include all genomic regions.
#' ## A peak from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr1", "chr10"), c(249250621, 135534747), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_FOXA1_01_NarrowPeaks_partial,
#'                             A549_FOSL2_01_NarrowPeaks_partial),
#'     peaks = c(A549_FOXA1_01_Peaks_partial,
#'                             A549_FOSL2_01_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 150,
#'     expandToFitPeakRegion = FALSE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL

#' Sites with the greatest evidence of transcription factor binding
#' for the FOXA1 transcription factor (for demonstration purpose)
#'
#' Sites representing the greatest evidence of enrichment for
#' the FOXA1 transcription factor (DCC accession: ENCFF000NAH)
#' for regions chr1:249120200-249250621 and chr10:1-370100
#' from the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' @name A549_FOXA1_01_Peaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site
#' . Each row of \code{GRanges} has a name which represent the name of
#' the experiment.
#'
#' @usage data(A549_FOXA1_01_Peaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF000NAH)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_FOXA1_01_NarrowPeaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_FOSL2_01_NarrowPeaks_partial)
#' data(A549_FOSL2_01_Peaks_partial)
#' data(A549_FOXA1_01_NarrowPeaks_partial)
#' data(A549_FOXA1_01_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_FOXA1_01_Peaks_partial) <- rep("FOXA1_01",
#'         length(A549_FOXA1_01_Peaks_partial))
#' names(A549_FOXA1_01_NarrowPeaks_partial) <- rep("FOXA1_01",
#'         length(A549_FOXA1_01_NarrowPeaks_partial))
#' names(A549_FOSL2_01_Peaks_partial) <-rep("FOSL2_01",
#'         length(A549_FOSL2_01_Peaks_partial))
#' names(A549_FOSL2_01_NarrowPeaks_partial) <- rep("FOSL2_01",
#'         length(A549_FOSL2_01_NarrowPeaks_partial))
#'
#' ## Calculating consensus regions for both chromosomes 1 and 10
#' ## with a default region size of 100 bp (2 * extendingSize)
#' ## which is extended to include all genomic regions for the closest
#' ## peak to the median position of all peaks included in the region (for each
#' ## experiment).
#' ## A peak from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr1", "chr10"), c(249250621, 135534747), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_FOXA1_01_NarrowPeaks_partial,
#'                             A549_FOSL2_01_NarrowPeaks_partial),
#'     peaks = c(A549_FOXA1_01_Peaks_partial,
#'                             A549_FOSL2_01_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 50,
#'     expandToFitPeakRegion = TRUE,
#'     shrinkToFitPeakRegion = TRUE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL

#' Sites with the greatest evidence of transcription factor binding
#' for the CTCF transcription factor (for demonstration purpose)
#'
#' Sites representing the greatest evidence of enrichment for
#' the CTCF transcription factor (DCC accession: ENCFF000MYJ)
#' for regions chr1:246000000-249250621 and chr10:10000000-12500000
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' @name A549_CTCF_MYJ_NarrowPeaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site.
#'
#' @usage data(A549_CTCF_MYJ_NarrowPeaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF000MYJ)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_CTCF_MYJ_Peaks_partial}} { the associate
#' genomic peaks dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }A549_CTCF_MYJ_NarrowPeaks_partial
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_CTCF_MYJ_NarrowPeaks_partial)
#' data(A549_CTCF_MYJ_Peaks_partial)
#' data(A549_CTCF_MYN_NarrowPeaks_partial)
#' data(A549_CTCF_MYN_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_CTCF_MYJ_Peaks_partial) <- rep("CTCF_MYJ",
#'                             length(A549_CTCF_MYJ_Peaks_partial))
#' names(A549_CTCF_MYJ_NarrowPeaks_partial) <- rep("CTCF_MYJ",
#'                             length(A549_CTCF_MYJ_NarrowPeaks_partial))
#' names(A549_CTCF_MYN_Peaks_partial) <-rep("CTCF_MYN",
#'                             length(A549_CTCF_MYN_Peaks_partial))
#' names(A549_CTCF_MYN_NarrowPeaks_partial) <- rep("CTCF_MYN",
#'                             length(A549_CTCF_MYN_NarrowPeaks_partial))
#'
#' ## Calculating consensus regions for chromosome 10
#' ## with a default region size of 100 bp (2 * extendingSize)
#' ## which is extended to include all genomic regions for the closest
#' ## peak to the median position of all peaks included in the region (for each
#' ## experiment).
#' ## A peak from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr10"), c(135534747), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_CTCF_MYJ_NarrowPeaks_partial,
#'                             A549_CTCF_MYN_NarrowPeaks_partial),
#'     peaks = c(A549_CTCF_MYJ_Peaks_partial,
#'                             A549_CTCF_MYN_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 50,
#'     expandToFitPeakRegion = TRUE,
#'     shrinkToFitPeakRegion = TRUE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Sites with the greatest evidence of transcription factor binding
#' for the CTCF transcription factor (for demonstration purpose)
#'
#' Sites representing the greatest evidence of enrichment for
#' the CTCF transcription factor (DCC accession: ENCFF000MYJ)
#' for regions chr1:246000000-249250621 and chr10:10000000-12500000
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' @name A549_CTCF_MYJ_Peaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site.
#'
#' @usage data(A549_CTCF_MYJ_Peaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF000MYJ)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_CTCF_MYJ_NarrowPeaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_CTCF_MYJ_NarrowPeaks_partial)
#' data(A549_CTCF_MYJ_Peaks_partial)
#' data(A549_CTCF_MYN_NarrowPeaks_partial)
#' data(A549_CTCF_MYN_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_CTCF_MYJ_Peaks_partial) <- rep("CTCF_MYJ",
#'                             length(A549_CTCF_MYJ_Peaks_partial))
#' names(A549_CTCF_MYJ_NarrowPeaks_partial) <- rep("CTCF_MYJ",
#'                             length(A549_CTCF_MYJ_NarrowPeaks_partial))
#' names(A549_CTCF_MYN_Peaks_partial) <-rep("CTCF_MYN",
#'                             length(A549_CTCF_MYN_Peaks_partial))
#' names(A549_CTCF_MYN_NarrowPeaks_partial) <- rep("CTCF_MYN",
#'                             length(A549_CTCF_MYN_NarrowPeaks_partial))
#'
#' ## Calculating consensus regions for chromosome 10
#' ## with a default region size of 40 bp (2 * extendingSize)
#' ## which is extended to include all genomic regions for the closest
#' ## peak to the median position of all peaks included in the region (for each
#' ## experiment).
#' ## A peak from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr10"), c(135534747), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_CTCF_MYJ_NarrowPeaks_partial,
#'                             A549_CTCF_MYN_NarrowPeaks_partial),
#'     peaks = c(A549_CTCF_MYJ_Peaks_partial,
#'                             A549_CTCF_MYN_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 20,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Sites with the greatest evidence of transcription factor binding
#' for the CTCF transcription factor (for demonstration purpose)
#'
#' Sites representing the greatest evidence of enrichment for
#' the CTCF transcription factor (DCC accession: ENCFF000MYN)
#' for regions chr1:246000000-249250621 and chr10:10000000-12500000
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' @name A549_CTCF_MYN_NarrowPeaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site.
#'
#' @usage data(A549_CTCF_MYN_NarrowPeaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF000MYN)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_CTCF_MYN_Peaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_CTCF_MYJ_NarrowPeaks_partial)
#' data(A549_CTCF_MYJ_Peaks_partial)
#' data(A549_CTCF_MYN_NarrowPeaks_partial)
#' data(A549_CTCF_MYN_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_CTCF_MYJ_Peaks_partial) <- rep("CTCF_MYJ",
#'                             length(A549_CTCF_MYJ_Peaks_partial))
#' names(A549_CTCF_MYJ_NarrowPeaks_partial) <- rep("CTCF_MYJ",
#'                             length(A549_CTCF_MYJ_NarrowPeaks_partial))
#' names(A549_CTCF_MYN_Peaks_partial) <-rep("CTCF_MYN",
#'                             length(A549_CTCF_MYN_Peaks_partial))
#' names(A549_CTCF_MYN_NarrowPeaks_partial) <- rep("CTCF_MYN",
#'                             length(A549_CTCF_MYN_NarrowPeaks_partial))
#'
#' ## Calculating consensus regions for chromosome 10
#' ## with a default region size of 40 bp (2 * extendingSize)
#' ## which is extended to include all genomic regions for the closest
#' ## peak to the median position of all peaks included in the region (for each
#' ## experiment).
#' ## A peak from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo("chr10", 135534747, NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_CTCF_MYJ_NarrowPeaks_partial,
#'                             A549_CTCF_MYN_NarrowPeaks_partial),
#'     peaks = c(A549_CTCF_MYJ_Peaks_partial,
#'                             A549_CTCF_MYN_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 20,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Sites with the greatest evidence of transcription factor binding
#' for the CTCF transcription factor (for demonstration purpose)
#'
#' Sites representing the greatest evidence of enrichment for
#' the CTCF transcription factor (DCC accession: ENCFF000MYN)
#' for regions chr1:246000000-249250621 and chr10:10000000-12500000
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' @name A549_CTCF_MYN_Peaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site.
#'
#' @usage data(A549_CTCF_MYN_Peaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF000MYN)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_CTCF_MYN_NarrowPeaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_CTCF_MYJ_NarrowPeaks_partial)
#' data(A549_CTCF_MYJ_Peaks_partial)
#' data(A549_CTCF_MYN_NarrowPeaks_partial)
#' data(A549_CTCF_MYN_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_CTCF_MYJ_Peaks_partial) <- rep("CTCF_MYJ",
#'                             length(A549_CTCF_MYJ_Peaks_partial))
#' names(A549_CTCF_MYJ_NarrowPeaks_partial) <- rep("CTCF_MYJ",
#'                             length(A549_CTCF_MYJ_NarrowPeaks_partial))
#' names(A549_CTCF_MYN_Peaks_partial) <-rep("CTCF_MYN",
#'                             length(A549_CTCF_MYN_Peaks_partial))
#' names(A549_CTCF_MYN_NarrowPeaks_partial) <- rep("CTCF_MYN",
#'                             length(A549_CTCF_MYN_NarrowPeaks_partial))
#'
#' ## Calculating consensus regions for chromosomes 1
#' ## with a default region size of 40 bp (2 * extendingSize)
#' ## which is extended to include all genomic regions for the closest
#' ## peak to the median position of all peaks included in the region (for each
#' ## experiment).
#' ## A peak from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr1"), c(249250621), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_CTCF_MYJ_NarrowPeaks_partial,
#'                             A549_CTCF_MYN_NarrowPeaks_partial),
#'     peaks = c(A549_CTCF_MYJ_Peaks_partial,
#'                             A549_CTCF_MYN_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 20,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Sites with the greatest evidence of transcription factor binding
#' for the NR3C1 transcription factor from ENCODE (DDC accession: ENCFF002CFQ).
#' For demonstration purpose.
#'
#' Sites representing the greatest evidence of enrichment for
#' the NR3C1 transcription factor (DCC accession: ENCFF002CFQ)
#' for regions chr2:40000000-50000000 and chr3:10000000-13000000
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' The peaks and ranges have been obtained using an optimal IDR analysis
#' done on all replicates.
#'
#' @name A549_NR3C1_CFQ_Peaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site. The peaks are
#' surronded by ranges present in the dataset
#' \code{A549_NR3C1_CFQ_NarrowPeaks_partial}.
#'
#' @usage data(A549_NR3C1_CFQ_Peaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF002CFQ)
#'
#' @references
#' \itemize{
#'     \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_NR3C1_CFQ_NarrowPeaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_NR3C1_CFQ_NarrowPeaks_partial)
#' data(A549_NR3C1_CFQ_Peaks_partial)
#' data(A549_NR3C1_CFS_NarrowPeaks_partial)
#' data(A549_NR3C1_CFS_Peaks_partial)
#' data(A549_NR3C1_CFR_NarrowPeaks_partial)
#' data(A549_NR3C1_CFR_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_NR3C1_CFQ_NarrowPeaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_NarrowPeaks_partial))
#' names(A549_NR3C1_CFQ_Peaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_Peaks_partial))
#' names(A549_NR3C1_CFS_NarrowPeaks_partial) <-rep("NR3C1_CFS",
#'                             length(A549_NR3C1_CFS_NarrowPeaks_partial))
#' names(A549_NR3C1_CFS_Peaks_partial) <- rep("NR3C1_CFS",
#'                             length(A549_NR3C1_CFS_Peaks_partial))
#' names(A549_NR3C1_CFR_NarrowPeaks_partial) <-rep("NR3C1_CFR",
#'                             length(A549_NR3C1_CFR_NarrowPeaks_partial))
#' names(A549_NR3C1_CFR_Peaks_partial) <- rep("NR3C1_CFR",
#'                             length(A549_NR3C1_CFR_Peaks_partial))
#'
#' ## Calculating consensus regions for chromosome 3
#' ## with a default region size of 140 bp (2 * extendingSize)
#' ## which is extended to include all genomic regions for the closest
#' ## peak to the median position of all peaks included in the region (for
#' ## each experiment).
#' ## Peaks from at least 2 experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr3"), c(198022430), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_NR3C1_CFQ_NarrowPeaks_partial,
#'                             A549_NR3C1_CFS_NarrowPeaks_partial,
#'                             A549_NR3C1_CFR_NarrowPeaks_partial),
#'     peaks = c(A549_NR3C1_CFQ_Peaks_partial,
#'                             A549_NR3C1_CFS_Peaks_partial,
#'                             A549_NR3C1_CFR_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 70,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Ranges with the greatest evidence of transcription factor binding
#' for the NR3C1 transcription factor from ENCODE (DDC accession: ENCFF002CFQ).
#' For demonstration purpose.
#'
#' Ranges representing the greatest evidence of enrichment for
#' the NR3C1 transcription factor (DCC accession: ENCFF002CFQ)
#' for regions chr2:40000000-50000000 and chr3:10000000-13000000
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' The peaks and ranges have been obtained using an optimal IDR analysis
#' done on all replicates.
#'
#' @name A549_NR3C1_CFQ_NarrowPeaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site. The ranges are
#' surronding the peaks present in the dataset
#' \code{A549_NR3C1_CFQ_Peaks_partial}.
#'
#' @usage data(A549_NR3C1_CFQ_NarrowPeaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF002CFQ)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_NR3C1_CFQ_Peaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_NR3C1_CFQ_NarrowPeaks_partial)
#' data(A549_NR3C1_CFQ_Peaks_partial)
#' data(A549_NR3C1_CFS_NarrowPeaks_partial)
#' data(A549_NR3C1_CFS_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_NR3C1_CFQ_NarrowPeaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_NarrowPeaks_partial))
#' names(A549_NR3C1_CFQ_Peaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_Peaks_partial))
#' names(A549_NR3C1_CFS_NarrowPeaks_partial) <-rep("NR3C1_CFS",
#'                             length(A549_NR3C1_CFS_NarrowPeaks_partial))
#' names(A549_NR3C1_CFS_Peaks_partial) <- rep("NR3C1_CFS",
#'                             length(A549_NR3C1_CFS_Peaks_partial))
#'
#' ## Calculating consensus regions for chromosome 3
#' ## with a default region size of 300 bp (2 * extendingSize)
#' ## which is extended to include all genomic regions for the closest
#' ## peak to the median position of all peaks included in the region (for
#' ## each experiment).
#' ## Peaks from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr3"), c(198022430), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_NR3C1_CFQ_NarrowPeaks_partial,
#'                             A549_NR3C1_CFS_NarrowPeaks_partial),
#'     peaks = c(A549_NR3C1_CFQ_Peaks_partial,
#'                             A549_NR3C1_CFS_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 150,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = TRUE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Sites with the greatest evidence of transcription factor binding
#' for the NR3C1 transcription factor from ENCODE (DDC accession: ENCFF002CFR).
#' For demonstration purpose.
#'
#' Sites representing the greatest evidence of enrichment for
#' the NR3C1 transcription factor (DCC accession: ENCFF002CFR)
#' for regions chr2:40000000-50000000 and chr3:10000000-13000000
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' The peaks and ranges have been obtained using an optimal IDR analysis
#' done on all replicates.
#'
#' @name A549_NR3C1_CFR_Peaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site. The peaks are
#' surronded by ranges present in the dataset
#' \code{A549_NR3C1_CFR_NarrowPeaks_partial}.
#'
#' @usage data(A549_NR3C1_CFR_Peaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF002CFR)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_NR3C1_CFR_NarrowPeaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_NR3C1_CFQ_NarrowPeaks_partial)
#' data(A549_NR3C1_CFQ_Peaks_partial)
#' data(A549_NR3C1_CFR_NarrowPeaks_partial)
#' data(A549_NR3C1_CFR_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_NR3C1_CFQ_NarrowPeaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_NarrowPeaks_partial))
#' names(A549_NR3C1_CFQ_Peaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_Peaks_partial))
#' names(A549_NR3C1_CFR_NarrowPeaks_partial) <-rep("NR3C1_CFR",
#'                             length(A549_NR3C1_CFR_NarrowPeaks_partial))
#' names(A549_NR3C1_CFR_Peaks_partial) <- rep("NR3C1_CFR",
#'                             length(A549_NR3C1_CFR_Peaks_partial))
#'
#' ## Calculating consensus regions for chromosome 2
#' ## with a default region size of 40 bp (2 * extendingSize)
#' ## which is extended to include all genomic regions for the closest
#' ## peak to the median position of all peaks included in the region (for
#' ## each experiment).
#' ## Peaks from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr2"), c(243199373), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_NR3C1_CFQ_NarrowPeaks_partial,
#'                             A549_NR3C1_CFR_NarrowPeaks_partial),
#'     peaks = c(A549_NR3C1_CFQ_Peaks_partial,
#'                             A549_NR3C1_CFR_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 20,
#'     expandToFitPeakRegion = TRUE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Ranges with the greatest evidence of transcription factor binding
#' for the NR3C1 transcription factor from ENCODE (DDC accession: ENCFF002CFR).
#' For demonstration purpose.
#'
#' Ranges representing the greatest evidence of enrichment for
#' the NR3C1 transcription factor (DCC accession: ENCFF002CFR)
#' for regions chr2:40000000-50000000 and chr3:10000000-13000000
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' The peaks and ranges have been obtained using an optimal IDR analysis
#' done on all replicates.
#'
#' @name A549_NR3C1_CFR_NarrowPeaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site. The ranges are
#' surronding the peaks present in the dataset
#' \code{A549_NR3C1_CFR_Peaks_partial}.
#'
#' @usage data(A549_NR3C1_CFR_NarrowPeaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF002CFR)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_NR3C1_CFR_Peaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_NR3C1_CFQ_NarrowPeaks_partial)
#' data(A549_NR3C1_CFQ_Peaks_partial)
#' data(A549_NR3C1_CFR_NarrowPeaks_partial)
#' data(A549_NR3C1_CFR_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_NR3C1_CFQ_NarrowPeaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_NarrowPeaks_partial))
#' names(A549_NR3C1_CFQ_Peaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_Peaks_partial))
#' names(A549_NR3C1_CFR_NarrowPeaks_partial) <-rep("NR3C1_CFR",
#'                             length(A549_NR3C1_CFR_NarrowPeaks_partial))
#' names(A549_NR3C1_CFR_Peaks_partial) <- rep("NR3C1_CFR",
#'                             length(A549_NR3C1_CFR_Peaks_partial))
#'
#' ## Calculating consensus regions for chromosome 2
#' ## with a default region size of 250 bp (2 * extendingSize)
#' ## which is extended to include all genomic regions for the closest
#' ## peak to the median position of all peaks included in the region (for
#' ## each experiment).
#' ## Peaks from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr2"), c(243199373), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_NR3C1_CFQ_NarrowPeaks_partial,
#'                             A549_NR3C1_CFR_NarrowPeaks_partial),
#'     peaks = c(A549_NR3C1_CFQ_Peaks_partial,
#'                             A549_NR3C1_CFR_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 125,
#'     expandToFitPeakRegion = TRUE,
#'     shrinkToFitPeakRegion = TRUE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL

#' Sites with the greatest evidence of transcription factor binding
#' for the NR3C1 transcription factor from ENCODE (DDC accession: ENCFF002CFS).
#' For demonstration purpose.
#'
#' Sites representing the greatest evidence of enrichment for
#' the NR3C1 transcription factor (DCC accession: ENCFF002CFS)
#' for regions chr2:40000000-50000000 and chr3:10000000-13000000
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' The peaks and ranges have been obtained using an optimal IDR analysis
#' done on all replicates.
#'
#' @name A549_NR3C1_CFS_Peaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site. The peaks are
#' surronded by ranges present in the dataset
#' \code{A549_NR3C1_CFS_NarrowPeaks_partial}.
#'
#' @usage data(A549_NR3C1_CFS_Peaks_partial)
#'
#' @source The Encyclopedia of DNA Elements (ENCODE) (DCC accession:
#' ENCFF002CFS)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_NR3C1_CFS_NarrowPeaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_NR3C1_CFQ_NarrowPeaks_partial)
#' data(A549_NR3C1_CFQ_Peaks_partial)
#' data(A549_NR3C1_CFS_NarrowPeaks_partial)
#' data(A549_NR3C1_CFS_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_NR3C1_CFQ_NarrowPeaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_NarrowPeaks_partial))
#' names(A549_NR3C1_CFQ_Peaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_Peaks_partial))
#' names(A549_NR3C1_CFS_NarrowPeaks_partial) <-rep("NR3C1_CFS",
#'                             length(A549_NR3C1_CFS_NarrowPeaks_partial))
#' names(A549_NR3C1_CFS_Peaks_partial) <- rep("NR3C1_CFS",
#'                             length(A549_NR3C1_CFS_Peaks_partial))
#'
#' ## Calculating consensus regions for chromosome 2
#' ## with a default region size of 80 bp (2 * extendingSize).
#' ## The consensus regions are not resized to fit the narrowPeak regions.
#' ## Peaks from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr2"), c(243199373), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_NR3C1_CFQ_NarrowPeaks_partial,
#'                             A549_NR3C1_CFS_NarrowPeaks_partial),
#'     peaks = c(A549_NR3C1_CFQ_Peaks_partial,
#'                             A549_NR3C1_CFS_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 40,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Ranges with the greatest evidence of transcription factor binding
#' for the NR3C1 transcription factor from ENCODE (DDC accession: ENCFF002CFS).
#' For demonstration purpose.
#'
#' Ranges representing the greatest evidence of enrichment for
#' the NR3C1 transcription factor (DCC accession: ENCFF002CFS)
#' for regions chr2:40000000-50000000 and chr3:10000000-13000000
#' from
#' the Encyclopedia of DNA Elements (ENCODE) data (Dunham I et al. 2012).
#'
#' The peaks and ranges have been obtained using an optimal IDR analysis
#' done on all replicates.
#'
#' @name A549_NR3C1_CFS_NarrowPeaks_partial
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per site. The ranges are
#' surronding the peaks present in the dataset
#' \code{A549_NR3C1_CFs_Peaks_partial}.
#'
#' @usage data(A549_NR3C1_CFS_NarrowPeaks_partial)
#'
#' @references
#' \itemize{
#' \item Dunham I, Kundaje A, Aldred SF, et al. An integrated encyclopedia
#' of DNA elements in the human genome. Nature. 2012 Sep 6;489(7414):57-74.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{A549_NR3C1_CFS_Peaks_partial}} { the associate
#' genomic regions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing the same features in more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_NR3C1_CFQ_NarrowPeaks_partial)
#' data(A549_NR3C1_CFQ_Peaks_partial)
#' data(A549_NR3C1_CFS_NarrowPeaks_partial)
#' data(A549_NR3C1_CFS_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_NR3C1_CFQ_NarrowPeaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_NarrowPeaks_partial))
#' names(A549_NR3C1_CFQ_Peaks_partial) <- rep("NR3C1_CFQ",
#'                             length(A549_NR3C1_CFQ_Peaks_partial))
#' names(A549_NR3C1_CFS_NarrowPeaks_partial) <-rep("NR3C1_CFS",
#'                             length(A549_NR3C1_CFS_NarrowPeaks_partial))
#' names(A549_NR3C1_CFS_Peaks_partial) <- rep("NR3C1_CFS",
#'                             length(A549_NR3C1_CFS_Peaks_partial))
#'
#' ## Calculating consensus regions for chromosome 2
#' ## with a default region size of 400 bp (2 * extendingSize).
#' ## The consensus regions are not resized to fit the narrowPeak regions.
#' ## Peaks from both experiments must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr2"), c(243199373), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(A549_NR3C1_CFQ_NarrowPeaks_partial,
#'                             A549_NR3C1_CFS_NarrowPeaks_partial),
#'     peaks = c(A549_NR3C1_CFQ_Peaks_partial,
#'                             A549_NR3C1_CFS_Peaks_partial),
#'     chrInfo = chrList,
#'     extendingSize = 200,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Ranges associated to nucleosomes detected by the PING software using
#' syntetic reads generated using a normal distribution.
#' For demonstration purpose.
#'
#' Ranges associated to nucleosomes detected by the PING software using
#' syntetic reads generated using a normal distribution with a variance
#' of 20 for regions chr1:10000-15000.
#'
#' @name PING_nucleosome_ranges
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per detected
#' nucleosome. The ranges are surronding the nucleosomes present in the dataset
#' \code{PING_nucleosome_positions}. The genomic ranges have been obtained by
#' adding  73 bps on both sides of the detected positions.
#'
#' @usage data(PING_nucleosome_ranges)
#'
#' @references
#' \itemize{
#' \item Sangsoon W, Zhang X, Sauteraud R, Robert F and Gottardo R. 2013.
#' PING 2.0: An R/Bioconductor package for nucleosome positioning using
#' next-generation sequencing data. Bioinformatics 29 (16): 2049-50.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{PING_nucleosome_positions}} { the associate
#' genomic positions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing nucleosomes from more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(PING_nucleosome_positions)
#' data(PING_nucleosome_ranges)
#' data(NOrMAL_nucleosome_positions)
#' data(NOrMAL_nucleosome_ranges)
#' data(NucPosSimulator_nucleosome_positions)
#' data(NucPosSimulator_nucleosome_ranges)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## Position and range datasets from the same sofware must
#' ## have identical names.
#' names(PING_nucleosome_positions) <- rep("PING",
#'                             length(PING_nucleosome_positions))
#' names(PING_nucleosome_ranges) <- rep("PING",
#'                             length(PING_nucleosome_ranges))
#' names(NOrMAL_nucleosome_positions) <-rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_positions))
#' names(NOrMAL_nucleosome_ranges) <- rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_ranges))
#' names(NucPosSimulator_nucleosome_positions) <-rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_positions))
#' names(NucPosSimulator_nucleosome_ranges) <- rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_ranges))
#'
#' ## Calculating consensus regions for chromosome 1
#' ## with a default region size of 20 bp (2 * extendingSize).
#' ## which is not extended to include all genomic regions for the closest
#' ## peak to the median position of all peaks included in the region (for
#' ## each experiment).
#' ## Nucleosomes from at least 2 software must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr1"), c(249250621), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(PING_nucleosome_ranges,
#'                             NOrMAL_nucleosome_ranges,
#'                             NucPosSimulator_nucleosome_ranges),
#'     peaks = c(PING_nucleosome_positions,
#'                             NOrMAL_nucleosome_positions,
#'                             NucPosSimulator_nucleosome_positions),
#'     chrInfo = chrList,
#'     extendingSize = 10,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Nucleosome positions detected by the PING software using
#' syntetic reads generated using a normal distribution.
#' For demonstration purpose.
#'
#' Nucleosome positions detected by the PING software using
#' syntetic reads generated using a normal distribution with a variance
#' of 20 for regions chr1:10000-15000.
#'
#' @name PING_nucleosome_positions
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per detected
#' nucleosome. The surronding ranges associated to those nucleosomes are in
#' the dataset \code{PING_nucleosome_positions}.
#'
#' @usage data(PING_nucleosome_positions)
#'
#' @references
#' \itemize{
#' \item Sangsoon W, Zhang X, Sauteraud R, Robert F and Gottardo R. 2013.
#' PING 2.0: An R/Bioconductor package for nucleosome positioning using
#' next-generation sequencing data. Bioinformatics 29 (16): 2049-50.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{PING_nucleosome_ranges}} { the associate
#' genomic ranges dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing nucleosomes from more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(PING_nucleosome_positions)
#' data(PING_nucleosome_ranges)
#' data(NOrMAL_nucleosome_positions)
#' data(NOrMAL_nucleosome_ranges)
#' data(NucPosSimulator_nucleosome_positions)
#' data(NucPosSimulator_nucleosome_ranges)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## Position and range datasets from the same sofware must
#' ## have identical names.
#' names(PING_nucleosome_positions) <- rep("PING",
#'                             length(PING_nucleosome_positions))
#' names(PING_nucleosome_ranges) <- rep("PING",
#'                             length(PING_nucleosome_ranges))
#' names(NOrMAL_nucleosome_positions) <-rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_positions))
#' names(NOrMAL_nucleosome_ranges) <- rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_ranges))
#' names(NucPosSimulator_nucleosome_positions) <-rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_positions))
#' names(NucPosSimulator_nucleosome_ranges) <- rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_ranges))
#'
#' ## Calculating consensus regions for chromosome 1
#' ## with a default region size of 20 bp (2 * extendingSize).
#' ## The consensus regions are not resized to fit genomic ranges of the
#' ## included nucleosomes.
#' ## Nucleosomes from at least 2 software must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr1"), c(249250621), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(PING_nucleosome_ranges,
#'                             NOrMAL_nucleosome_ranges,
#'                             NucPosSimulator_nucleosome_ranges),
#'     peaks = c(PING_nucleosome_positions,
#'                             NOrMAL_nucleosome_positions,
#'                             NucPosSimulator_nucleosome_positions),
#'     chrInfo = chrList,
#'     extendingSize = 10,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 3,
#'     nbrThreads = 1)
#'
NULL


#' Ranges associated to nucleosomes detected by the NOrMAL software using
#' syntetic reads generated using a normal distribution.
#' For demonstration purpose.
#'
#' Ranges associated to nucleosomes detected by the NOrMAL software using
#' syntetic reads generated using a normal distribution with a variance
#' of 20 for regions chr1:10000-15000.
#'
#' @name NOrMAL_nucleosome_ranges
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per detected
#' nucleosome. The ranges are surronding the nucleosomes present in the dataset
#' \code{NOrMAL_nucleosome_positions}. The genomic ranges have been obtained by
#' adding 73 bps on each side of the detected positions.
#'
#' @usage data(NOrMAL_nucleosome_ranges)
#'
#' @references
#' \itemize{
#' \item Polishko A, Ponts N, Le Roch KG and Lonardi S. 2012. NOrMAL:
#' Accurate nucleosome positioning using a modified Gaussian mixture
#' model. Bioinformatics 28 (12): 242-49.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{NOrMAL_nucleosome_positions}} { the associate
#' genomic positions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing nucleosomes from more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(PING_nucleosome_positions)
#' data(PING_nucleosome_ranges)
#' data(NOrMAL_nucleosome_positions)
#' data(NOrMAL_nucleosome_ranges)
#' data(NucPosSimulator_nucleosome_positions)
#' data(NucPosSimulator_nucleosome_ranges)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## Position and range datasets from the same sofware must
#' ## have identical names.
#' names(PING_nucleosome_positions) <- rep("PING",
#'                             length(PING_nucleosome_positions))
#' names(PING_nucleosome_ranges) <- rep("PING",
#'                             length(PING_nucleosome_ranges))
#' names(NOrMAL_nucleosome_positions) <-rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_positions))
#' names(NOrMAL_nucleosome_ranges) <- rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_ranges))
#' names(NucPosSimulator_nucleosome_positions) <-rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_positions))
#' names(NucPosSimulator_nucleosome_ranges) <- rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_ranges))
#'
#' ## Calculating consensus regions for chromosome 1
#' ## with a default region size of 30 bp (2 * extendingSize).
#' ## Consensus regions are resized to include all genomic regions of
#' ## included nucleosomes.
#' ## Nucleosomes from at least 2 software must be present
#' ## in a region to be retained as a consensus region.
#' chrList <- Seqinfo(c("chr1"), c(249250621), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(PING_nucleosome_ranges,
#'                             NOrMAL_nucleosome_ranges,
#'                             NucPosSimulator_nucleosome_ranges),
#'     peaks = c(PING_nucleosome_positions,
#'                             NOrMAL_nucleosome_positions,
#'                             NucPosSimulator_nucleosome_positions),
#'     chrInfo = chrList,
#'     extendingSize = 15,
#'     expandToFitPeakRegion = TRUE,
#'     shrinkToFitPeakRegion = TRUE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Nucleosome positions detected by the NOrMAL software using
#' syntetic reads generated using a normal distribution.
#' For demonstration purpose.
#'
#' Nucleosome positions detected by the NOrMAL software using
#' syntetic reads generated using a normal distribution with a variance
#' of 20 for regions chr1:10000-15000.
#'
#' @name NOrMAL_nucleosome_positions
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per detected
#' nucleosome. The surronding ranges associated to those nucleosomes are in
#' the dataset \code{NOrMAL_nucleosome_ranges}.
#'
#' @usage data(NOrMAL_nucleosome_positions)
#'
#' @references
#' \itemize{
#' \item Polishko A, Ponts N, Le Roch KG and Lonardi S. 2012. NOrMAL:
#' Accurate nucleosome positioning using a modified Gaussian mixture
#' model. Bioinformatics 28 (12): 242-49.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{NOrMAL_nucleosome_ranges}} { the associate
#' genomic ranges dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing nucleosomes from more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(PING_nucleosome_positions)
#' data(PING_nucleosome_ranges)
#' data(NOrMAL_nucleosome_positions)
#' data(NOrMAL_nucleosome_ranges)
#' data(NucPosSimulator_nucleosome_positions)
#' data(NucPosSimulator_nucleosome_ranges)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## Position and range datasets from the same sofware must
#' ## have identical names.
#' names(PING_nucleosome_positions) <- rep("PING",
#'                             length(PING_nucleosome_positions))
#' names(PING_nucleosome_ranges) <- rep("PING",
#'                             length(PING_nucleosome_ranges))
#' names(NOrMAL_nucleosome_positions) <-rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_positions))
#' names(NOrMAL_nucleosome_ranges) <- rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_ranges))
#' names(NucPosSimulator_nucleosome_positions) <-rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_positions))
#' names(NucPosSimulator_nucleosome_ranges) <- rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_ranges))
#'
#' ## Calculating consensus regions for chromosome 1
#' ## with a default region size of 40 bp (2 * extendingSize).
#' ## The consensus regions are extended to include all genomic regions for
#' ## all nucleosomes. However, if the consensus regions are larger than the
#' ## genomic regions of the nucleosomes, the consensus regions are not
#' ## shrinked.
#' ## Nucleosomes from all software must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr1"), c(249250621), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(PING_nucleosome_ranges,
#'                         NOrMAL_nucleosome_ranges,
#'                         NucPosSimulator_nucleosome_ranges),
#'     peaks = c(PING_nucleosome_positions,
#'                         NOrMAL_nucleosome_positions,
#'                         NucPosSimulator_nucleosome_positions),
#'     chrInfo = chrList,
#'     extendingSize = 20,
#'     expandToFitPeakRegion = TRUE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 3,
#'     nbrThreads = 1)
#'
NULL


#' Ranges associated to nucleosomes detected by the NucPosSimulator software
#' using syntetic reads generated using a normal distribution.
#' For demonstration purpose.
#'
#' Ranges associated to nucleosomes detected by the NucPosSimulator software
#' using syntetic reads generated using a normal distribution with a variance
#' of 20 for regions chr1:10000-15000.
#'
#' @name NucPosSimulator_nucleosome_ranges
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per detected
#' nucleosome. The ranges are surronding the nucleosomes present in the dataset
#' \code{NucPosSimulator_nucleosome_positions}. The genomic ranges have been
#' obtained by adding 73 bps on each side of the detected positions.
#'
#' @usage data(NucPosSimulator_nucleosome_ranges)
#'
#' @references
#' \itemize{
#' \item Sch&ouml;pflin R, Teif VB, M&uuml;ller O, Weinberg C, Rippe K, and
#' Wedemann G. 2013. Modeling nucleosome position distributions from
#' experimental nucleosome positioning maps. Bioinformatics 29 (19): 2380-86.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{NucPosSimulator_nucleosome_positions}} { the associate
#' genomic positions dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing nucleosomes from more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(PING_nucleosome_positions)
#' data(PING_nucleosome_ranges)
#' data(NOrMAL_nucleosome_positions)
#' data(NOrMAL_nucleosome_ranges)
#' data(NucPosSimulator_nucleosome_positions)
#' data(NucPosSimulator_nucleosome_ranges)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## Position and range datasets from the same sofware must
#' ## have identical names.
#' names(PING_nucleosome_positions) <- rep("PING",
#'                             length(PING_nucleosome_positions))
#' names(PING_nucleosome_ranges) <- rep("PING",
#'                             length(PING_nucleosome_ranges))
#' names(NOrMAL_nucleosome_positions) <-rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_positions))
#' names(NOrMAL_nucleosome_ranges) <- rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_ranges))
#' names(NucPosSimulator_nucleosome_positions) <-rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_positions))
#' names(NucPosSimulator_nucleosome_ranges) <- rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_ranges))
#'
#' ## Calculating consensus regions for chromosome 1
#' ## with a default region size of 60 bp (2 * extendingSize).
#' ## Consensus regions are resized to include all genomic regions of
#' ## included nucleosomes.
#' ## Nucleosomes from at least 2 software must be present
#' ## in a region to be retained as a consensus region.
#' chrList <- Seqinfo(c("chr1"), c(249250621), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(PING_nucleosome_ranges,
#'                         NOrMAL_nucleosome_ranges,
#'                         NucPosSimulator_nucleosome_ranges),
#'     peaks = c(PING_nucleosome_positions,
#'                         NOrMAL_nucleosome_positions,
#'                         NucPosSimulator_nucleosome_positions),
#'     chrInfo = chrList,
#'     extendingSize = 30,
#'     expandToFitPeakRegion = TRUE,
#'     shrinkToFitPeakRegion = TRUE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
NULL


#' Nucleosome positions detected by the NucPosSimulator software using
#' syntetic reads generated using a normal distribution.
#' For demonstration purpose.
#'
#' Nucleosome positions detected by the NucPosSimulator software using
#' syntetic reads generated using a normal distribution with a variance
#' of 20 for regions chr1:10000-15000.
#'
#' @name NucPosSimulator_nucleosome_positions
#'
#' @docType data
#'
#' @format A \code{GRanges} containing one entry per detected
#' nucleosome. The surronding ranges associated to those nucleosomes are in
#' the dataset \code{NucPosSimulator_nucleosome_ranges}.
#'
#' @usage data(NucPosSimulator_nucleosome_positions)
#'
#' @references
#' \itemize{
#' \item Sch&ouml;pflin R, Teif VB, M&uuml;ller O, Weinberg C, Rippe K, and
#' Wedemann G. 2013. Modeling nucleosome position distributions from
#' experimental nucleosome positioning maps. Bioinformatics 29 (19): 2380-86.
#' }
#'
#' @seealso
#' \itemize{
#' \item \code{\link{NucPosSimulator_nucleosome_ranges}} { the associate
#' genomic ranges dataset.}
#' \item \code{\link{findConsensusPeakRegions}} {for extracting regions
#' sharing nucleosomes from more than one experiment.}
#' }
#' @keywords datasets
#'
#' @examples
#'
#' ## Loading datasets
#' data(PING_nucleosome_positions)
#' data(PING_nucleosome_ranges)
#' data(NOrMAL_nucleosome_positions)
#' data(NOrMAL_nucleosome_ranges)
#' data(NucPosSimulator_nucleosome_positions)
#' data(NucPosSimulator_nucleosome_ranges)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## Position and range datasets from the same sofware must
#' ## have identical names.
#' names(PING_nucleosome_positions) <- rep("PING",
#'                             length(PING_nucleosome_positions))
#' names(PING_nucleosome_ranges) <- rep("PING",
#'                             length(PING_nucleosome_ranges))
#' names(NOrMAL_nucleosome_positions) <-rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_positions))
#' names(NOrMAL_nucleosome_ranges) <- rep("NOrMAL",
#'                             length(NOrMAL_nucleosome_ranges))
#' names(NucPosSimulator_nucleosome_positions) <-rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_positions))
#' names(NucPosSimulator_nucleosome_ranges) <- rep("NucPosSimulator",
#'                             length(NucPosSimulator_nucleosome_ranges))
#'
#' ## Calculating consensus regions for chromosome 1
#' ## with a default region size of 50 bp (2 * extendingSize).
#' ## The consensus regions are extended to include all genomic regions for
#' ## all nucleosomes. However, if the consensus regions are larger than the
#' ## genomic regions of the nucleosomes, the consensus regions are not
#' ## shrinked.
#' ## Nucleosomes from all software must be present in a region to
#' ## be retained as a consensus region.
#' chrList <- Seqinfo(c("chr1"), c(249250621), NA)
#' findConsensusPeakRegions(
#'     narrowPeaks = c(PING_nucleosome_ranges,
#'                         NOrMAL_nucleosome_ranges,
#'                         NucPosSimulator_nucleosome_ranges),
#'     peaks = c(PING_nucleosome_positions,
#'                         NOrMAL_nucleosome_positions,
#'                         NucPosSimulator_nucleosome_positions),
#'     chrInfo = chrList,
#'     extendingSize = 25,
#'     expandToFitPeakRegion = TRUE,
#'     shrinkToFitPeakRegion = FALSE,
#'     minNbrExp = 3,
#'     nbrThreads = 1)
#'
NULL