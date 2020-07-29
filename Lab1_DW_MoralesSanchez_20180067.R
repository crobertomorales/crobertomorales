#String
sentence <- "This is a string"

#Double
number <- 234

class(number)
typeof(number)
length(number)

number_2 <- 1/8

typeof(number_2)

#Integer 
integer <- 2L
class(integer) #Se agrega la L para identificar que es un número entero
#Esto funciona como por ejemplo, no se pueden contar 2 personas y media.

#Logical
logical <- FALSE
class(logical)

#Vectores
num_vector <- c(1,2,3,4)
length(num_vector)

num_vector_2 <- c(1,2,3,4,"a")
length(num_vector_2)

vec1 <- 1:100
vec2 <- sample(x = 1:10, size = 5)
vector("integer", length = 10)

class(num_vector)
class(num_vector_2)

c(num_vector_2, 19, 2, 3, 4)

log_vec <- c(F,T,T)
class(log_vec)

as.numeric(num_vector_2)
as.character(num_vector)

#Factor
factor_1 <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
factor_1 <- factor(factor_1)

#Ordered Factors

factor2 <-  c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
factor2 <- ordered(factor2, levels =  c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))

#Lists
vector1 <- c(1:5)
vector2 <- c(F, F, T)
vector3 <- letters[1:6]



list_1 <- list(vector1, vector2, vector3)

names(list_1) <- c("Primero", "Segundo", "Tercero")
names(list_1)
list_1$Primero
list_1$Segundo
list_1$Tercero


# Matrix
iMi <- matrix(1:10, nrow = 2, ncol = 5)
iMi[,3]
iMi[2,]

a <- c(1,2,3,4,5,4,5,4,5)

col1 <- c("this","is","a","column","of","text")
col2 <- c(1:6)
col3 <- c(letters[1:6])
df <- data.frame(col1,col2,col3,
stringsAsFactors = F
)

df[1,]
df[,3]

head(df)
df

nrow(df)
ncol(df)

names(df)[2:3] <- c("c1","c2")
df

num_vector_3 <- as.numeric(num_vector_2)
is.na(num_vector_3)

num_vector_3
num_vector_3[!is.na(num_vector_3)]

