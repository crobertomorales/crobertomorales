library(readr)
data <- read_csv("tabla_completa.csv")
library(dplyr)

# Visión  general
viajes <- data %>% group_by(PILOTO) %>% summarise(SUD =  n())
clientes<- data %>% group_by(CLIENTE) %>% summarise(SUD = n())
vehiculos <- data %>% group_by(UNIDAD) %>% summarise(SUD = n(), dia = n()/330)
credito <- data %>% group_by(CREDITO) %>% summarise(SUD = n())
data$PAGO <- NA
for(i in 1:nrow(data)){
  if(data$CREDITO[i]  == 30){
    data$PAGO[i] <- data$MES[i]+1
  }
  if(data$CREDITO[i]  == 60){
    data$PAGO[i] <- data$MES[i]+2
  }
  if(data$CREDITO[i]  == 90){
    data$PAGO[i] <- data$MES[i]+3
  }
}

pilotos_g <- data %>% filter(UNIDAD=="Camion Grande") %>% group_by(PILOTO) %>% summarise(n  = n())
pilotos_pan <- data %>% filter(UNIDAD=="Panel") %>% group_by(PILOTO) %>% summarise(n  = n())
pilotos_p <- data %>% filter(UNIDAD!="Camion Grande" & UNIDAD!="Panel") %>% group_by(PILOTO) %>% summarise(n  = n())

# pregunta  1

descansos_anuales <- 12 + 15 + 52
de <- data$CANTIDAD / data$Q
de
disponibilidad <- 365 - viajes[,2] - descansos_anuales 
mensual <- data %>% group_by(MES) %>% summarise(n = n())
(sum(disponibilidad) - round(mean(mensual$n),0)) / (nrow(data) + round(mean(mensual$n),0))
viajes_persona <- 365 - descansos_anuales
viajes_persona / (nrow(data) + round(mean(mensual$n),0))

# pregunta 2

p_mes <- data %>% group_by(PILOTO,MES) %>% summarise(n = n())
vehiculos_mes <- data %>% group_by(UNIDAD,MES) %>% summarise(SUD = n())
vehiculos_rec <- data %>% group_by(UNIDAD) %>% summarise(SUD = n(), cash = sum(Q), tot = sum(Q)/sum(data$Q))
vehiculos_med <- data %>% group_by(UNIDAD) %>% summarise(SUD = n(), cash = mean(Q))
vehiculos_ <- data %>% group_by(UNIDAD,MES) %>% summarise(cam = n()/30)
#suponiendo  un flete al día por vehiculo, se estima que hay 4 camiones   grandes, 2 pequeños y 1 panel

data$CLIENTE_ <-  data$CLIENTE
for(i in 1:nrow(data)){
  if(data$CLIENTE[i]=="EL GALLO NEGRO / Despacho a cliente" | data$CLIENTE[i]=="EL GALLO NEGRO |||DEVOLUCION"){
    data$CLIENTE_[i] <- "EL GALLO NEGRO"
  }
  if(data$CLIENTE[i]=="EL PINCHE OBELISCO / Despacho a cliente" | data$CLIENTE[i]=="EL PINCHE OBELISCO |||Faltante"){
    data$CLIENTE_[i] <- "EL PINCHE OBELISCO"
  }
  if(data$CLIENTE[i]=="POLLO PINULITO/Despacho a cliente" | data$CLIENTE[i]=="POLLO PINULITO|||FALTANTE"){
    data$CLIENTE_[i] <- "POLLO PINULITO"
  }
  if(data$CLIENTE[i]=="TAQUERIA EL CHINITO" | data$CLIENTE[i]=="TAQUERIA EL CHINITO |||Faltante"){
    data$CLIENTE_[i] <- "TAQUERIA EL CHINITO"
  }
  if(data$CLIENTE[i]=="UBIQUO LABS" | data$CLIENTE[i]=="UBIQUO LABS |||FALTANTE"){
    data$CLIENTE_[i] <- "UBIQUO LABS"
  }
}
clientes <- data %>% group_by(CLIENTE_) %>% summarise(SUD = n()) %>% arrange(-SUD)
clientes_cash <- data %>% group_by(CLIENTE_) %>% summarise(SUD = n(),p  = n()/nrow(data), cash  = sum(Q),pc = sum(Q)/sum(data$Q)) %>% arrange(-cash)
v_c <- data %>% group_by(CLIENTE_,UNIDAD) %>% summarise(n())
rendimientos <- data %>% group_by(UNIDAD) %>%  summarise(rend = n())
unidades <- c(4,2,1)
rendimientos$rend <- rendimientos$rend / unidades
rendimientos$rend[1] / vehiculos$SUD[1]

# Pregunta 3

veh_cli  <- data  %>% group_by(CLIENTE_,MES) %>% summarise(cant = sum(CANTIDAD))
cams <- split(x = veh_cli,f = veh_cli$CLIENTE_)
asa <- function(a){
  p1 <- mean(a$cant[a$MES < 9])
  p2 <- mean(a$cant[a$MES >= 9])
  return(p2-p1)
}
aceptabilidad <- lapply(X = cams,FUN = asa)
aceptabilidad[1]

# pregunta 4
flujos  <- data %>% group_by(PAGO) %>% summarise(flujo = sum(Q))
flujos <- t(flujos)
flujos_ <- rbind(c("feb","mar","abr","may","jun","jul","ago","sep","oct","nov","dic","ene20","feb20"),flujos[2,])

# parte 2.1
write_excel_csv(x = clientes_cash,path = "top_clientes.xls")

mejores <- data %>% group_by(CLIENTE_) %>% summarise(in_viaje = sum(Q)/n())  %>% arrange(-in_viaje)
write_excel_csv(x = mejores,path = "mejores.xls")

# 2.2
m_pilotos  <-  data %>% group_by(PILOTO,MES) %>% summarise(viajes = n()) %>% group_by(PILOTO) %>% summarise(min(viajes))
write_excel_csv(x = viajes,path = "Pilotos.xls")
write_excel_csv(x = m_pilotos,path = "Pilotos2.xls")

write_excel_csv(x = vehiculos_rec,path = "vehi.xls")
write_excel_csv(x = vehiculos_med,path = "vehi2.xls")
