# create small dataset
df -> data.frame(A = c(1, NA, 8, NA),
                 B = c(3, NA, 88, 23),
                 C = c(2, 45, 3, 1))

# check for NAs
is.na(df)
