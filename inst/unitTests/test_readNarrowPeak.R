###################################################
# Created by Astrid Deschenes
# 2015-05-11
###################################################

###################################################
## Test the readnarrowPeak() function
###################################################

### {{{ --- Test setup ---

if(FALSE) {
    library( "RUnit" )
    library( "consensusSeekeR" )
}

### }}}

file_FOSL2_Rep01 <- dir(system.file("extdata", package = "consensusSeekeR"),
    pattern = "Hosa_A549_FOSL2_ENCSR000BQO_MZT_peaks_part_chr1_and_12.narrowPeak$",
    full.names = TRUE)


## Test the result when the file doesn't exist
test.readNarrowPeak_no_existing_file <- function() {
    file <- "TiiTooTiiToo.narrowPeak"
    obs <- tryCatch(readNarrowPeakFile(file_path = file),
                    error=conditionMessage)
    exp <- paste0("No such file \"", file, "\"")
    message <- paste0("readNarrowPeak_no_existing_file() ",
        "- A not existing file did not generated the expected exception.")
    checkEquals(obs, exp, msg = message)
}

## Test the result when extractPeaks and extractRegions parameters
## are both FALSE
test.readNarrowPeak_both_parameters_FALSE <- function() {
    obs <- tryCatch(readNarrowPeakFile(file_path = file_FOSL2_Rep01,
                    extractRegions = FALSE, extractPeaks = FALSE),
                    error=conditionMessage)
    exp <- "extractPeaks and extractRegions cannot be both FALSE"
    message <- paste0("readNarrowPeak_no_existing_file() ",
                     "- Both extractPeaks and extractRegions set to ",
                    "FALSE did not generated the expected exception.")
    checkEquals(obs, exp, msg = message)
}

## Test the result when extractPeaks is a string
test.readNarrowPeak_a_string_as_extractPeaks <- function() {
    obs <- tryCatch(readNarrowPeakFile(file_path = file_FOSL2_Rep01,
                                    extractRegions = FALSE,
                                    extractPeaks = "extremeYoga"),
                                    error=conditionMessage)
    exp <- "extractPeaks must be a logical value"
    message <- paste0("readNarrowPeak_no_existing_file() ",
                      "- A string used as extractPeaks parameter ",
                      "did not generated the expected exception.")
    checkEquals(obs, exp, msg = message)
}

## Test the result when extractPeaks is a numerical
test.readNarrowPeak_a_numerical_as_extractPeaks <- function() {
    obs <- tryCatch(readNarrowPeakFile(file_path = file_FOSL2_Rep01,
                                   extractRegions = FALSE,
                                   extractPeaks = 0.001),
                    error=conditionMessage)
    exp <- "extractPeaks must be a logical value"
    message <- paste0("readNarrowPeak_no_existing_file() ",
                      "- A string used as extractPeaks parameter ",
                      "did not generated the expected exception.")
    checkEquals(obs, exp, msg = message)
}

## Test the result when extractRegions is a string
test.readNarrowPeak_a_string_as_extractRegions <- function() {
    obs <- tryCatch(readNarrowPeakFile(file_path = file_FOSL2_Rep01,
                                   extractRegions = "extremeReading",
                                   extractPeaks = TRUE),
                    error=conditionMessage)
    exp <- "extractRegions must be a logical value"
    message <- paste0("readNarrowPeak_no_existing_file() ",
                      "- A string used as extractRegions parameter ",
                      "did not generated the expected exception.")
    checkEquals(obs, exp, msg = message)
}

# Test the result when extractRegions is an numerical
test.readNarrowPeak_a_numerical_as_extractRegions <- function() {
    obs <- tryCatch(readNarrowPeakFile(file_path = file_FOSL2_Rep01,
                                   extractRegions = 0.11,
                                   extractPeaks = TRUE),
                    error=conditionMessage)
    exp <- "extractRegions must be a logical value"
    message <- paste0("readNarrowPeak_no_existing_file() ",
                      "- A numerical used as extractRegions parameter ",
                      "did not generated the expected exception.")
    checkEquals(obs, exp, msg = message)
}

# Test good result
test.readNarrowPeak_good_result_extract_both <- function() {
    obs <- tryCatch(readNarrowPeakFile(file_path = file_FOSL2_Rep01,
                                       extractRegions = TRUE,
                                       extractPeaks = TRUE),
                    error=conditionMessage)

    message <- paste0("test.readNarrowPeak_good_result_extract_both() ",
                      "- readNarrowPeak() function ",
                      "did not generated the expected exception.")

    gRangesPeak <- IRanges(start = c(846674, 854168, 856527, 873950, 876259,
                                 876728, 878704, 879941, 880277, 880926),
                       end = c(846674, 854168, 856527, 873950, 876259,
                               876728, 878704, 879941, 880277, 880926))

    gRangesNarrowPeak <- IRanges(start = c(846569, 853983, 856354, 873590,
                                           876173, 876628, 878585, 879788,
                                           880179, 880842),
                           end = c(846825, 854288, 856740, 874218, 876431,
                                   876856, 878995, 880079, 880349, 881002))

    checkEquals(length(obs$narrowPeak), 52, msg = message)
    checkEquals(obs$narrowPeak$score[1:10],
                    c(135, 31, 68, 201, 39, 48, 123, 58, 28, 33),
                    msg = message)
    checkEquals(obs$narrowPeak$name[1:10],
                paste0(rep("peaks/Hosa_A549_FOSL2_ENCSR000BQO_ENCFF000MZT_peak_", 10),
                            1:10))
    checkEquals(obs$narrowPeak$peak[1:10],
                c(105, 185, 173, 360, 86, 100, 119, 153, 98, 84))
    checkEquals(obs$narrowPeak$signalValue[1:10],
                c(7.95395, 4.16604, 6.01762, 10.31659, 4.62894, 5.09183,
                  8.33209, 5.55473, 3.82096, 4.18846))
    checkEquals(obs$narrowPeak$pValue[1:10],
                c(16.34975, 5.42956, 9.42134, 23.07730, 6.36997, 7.35092,
                  15.12057,  8.36900, 5.10655, 5.68215))
    checkEquals(obs$narrowPeak$qValue[1:10],
                c(13.55616, 3.11208, 6.85834, 20.13679, 3.98205, 4.89159,
                  12.35894, 5.85624, 2.81792, 3.35093))
    checkEquals(seqnames(obs$narrowPeak), Rle(as.factor(c("chr1", "chr12")),
                                        c(19, 33)), msg = message)
    checkEquals(ranges(obs$narrowPeak)[1:10], gRangesNarrowPeak, msg = message)

    checkEquals(length(obs$peak), 52, msg = message)
    checkEquals(obs$peak$score[1:10],
                c(135, 31, 68, 201, 39, 48, 123, 58, 28, 33),
                msg = message)
    checkEquals(obs$peak$name[1:10],
                paste0(rep("peaks/Hosa_A549_FOSL2_ENCSR000BQO_ENCFF000MZT_peak_", 10),
                       1:10))
    checkEquals(obs$peak$peak[1:10],
                c(105, 185, 173, 360, 86, 100, 119, 153, 98, 84))
    checkEquals(obs$peak$signalValue[1:10],
                c(7.95395, 4.16604, 6.01762, 10.31659, 4.62894, 5.09183,
                  8.33209, 5.55473, 3.82096, 4.18846))
    checkEquals(obs$peak$pValue[1:10],
                c(16.34975, 5.42956, 9.42134, 23.07730, 6.36997, 7.35092,
                  15.12057,  8.36900, 5.10655, 5.68215))
    checkEquals(obs$peak$qValue[1:10],
                c(13.55616, 3.11208, 6.85834, 20.13679, 3.98205, 4.89159,
                  12.35894, 5.85624, 2.81792, 3.35093))
    checkEquals(seqnames(obs$peak), Rle(as.factor(c("chr1", "chr12")),
                c(19, 33)), msg = message)
    checkEquals(ranges(obs$peak)[1:10], gRangesPeak, msg = message)
}

# Test good result
test.readNarrowPeak_good_result_extract_only_peaks <- function() {
    obs <- tryCatch(readNarrowPeakFile(file_path = file_FOSL2_Rep01,
                                       extractRegions = FALSE,
                                       extractPeaks = TRUE),
                    error=conditionMessage)

    message <- paste0("test.readNarrowPeak_good_result_extract_only_peaks() ",
                      "- readNarrowPeak() function ",
                      "did not generated the expected exception.")

    gRangesPeak <- IRanges(start = c(846674, 854168, 856527, 873950, 876259,
                                     876728, 878704, 879941, 880277, 880926),
                           end = c(846674, 854168, 856527, 873950, 876259,
                                   876728, 878704, 879941, 880277, 880926))

    gRangesNarrowPeak <- IRanges(start = c(846569, 853983, 856354, 873590,
                                           876173, 876628, 878585, 879788,
                                           880179, 880842),
                                 end = c(846825, 854288, 856740, 874218, 876431,
                                         876856, 878995, 880079, 880349, 881002))

    checkTrue(is.null(obs$narrowPeak), msg = message)

    checkEquals(length(obs$peak), 52, msg = message)
    checkEquals(obs$peak$score[1:10],
                c(135, 31, 68, 201, 39, 48, 123, 58, 28, 33),
                msg = message)
    checkEquals(obs$peak$name[1:10],
                paste0(rep("peaks/Hosa_A549_FOSL2_ENCSR000BQO_ENCFF000MZT_peak_", 10),
                       1:10))
    checkEquals(obs$peak$peak[1:10],
                c(105, 185, 173, 360, 86, 100, 119, 153, 98, 84))
    checkEquals(obs$peak$signalValue[1:10],
                c(7.95395, 4.16604, 6.01762, 10.31659, 4.62894, 5.09183,
                  8.33209, 5.55473, 3.82096, 4.18846))
    checkEquals(obs$peak$pValue[1:10],
                c(16.34975, 5.42956, 9.42134, 23.07730, 6.36997, 7.35092,
                  15.12057,  8.36900, 5.10655, 5.68215))
    checkEquals(obs$peak$qValue[1:10],
                c(13.55616, 3.11208, 6.85834, 20.13679, 3.98205, 4.89159,
                  12.35894, 5.85624, 2.81792, 3.35093))
    checkEquals(seqnames(obs$peak), Rle(as.factor(c("chr1", "chr12")),
                                        c(19, 33)), msg = message)
    checkEquals(ranges(obs$peak)[1:10], gRangesPeak, msg = message)
}
