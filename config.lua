Config = {}

Config.UseJobCreator = true -- Use Job Creator

Config.UseItem = false --Use tablet ITEM

Config.VIPinPerfil = false --Get the column vip in the users table
Config.PenalCode = {
    
    {title = true, label = 'Capitulo I - Delitos de Tráfico'},
    
    {title = false, label = 'Art. 1.1 - Uso excesivo del claxon.', price = 250, time = '0 meses'},
    {title = false, label = 'Art. 1.2 - Invadir el carril contrario.', price = 250, time = '0 meses'},
    {title = false, label = 'Art. 1.3 - Giro indebido.', price = 300, time = '0 meses'},
    {title = false, label = 'Art. 1.4 - Conducir fuera de la carretera.', price = 270, time = '0 meses'},
    {title = false, label = 'Art. 1.5 - Rechazar una orden de la ley.', price = 550, time = '0 meses'},
    {title = false, label = 'Art. 1.6 - Vehículo en mal estado.', price = 250, time = '0 meses'},
    {title = false, label = 'Art. 1.7 - Estacionar en zonas no habilitadas y obstruir la circulación.', price = 550, time = '0 meses'},
    {title = false, label = 'Art. 1.8 - Conducción temeraria.', price = 650, time = '0 meses'},
    {title = false, label = 'Art. 1.9 - Incumplimiento de la información del vehículo.', price = 350, time = '0 meses'},
    {title = false, label = 'Art. 1.10 - Ignorar señales de tránsito.', price = 350, time = '0 meses'},
    {title = false, label = 'Art. 1.11 - Saltarse un semáforo.', price = 320, time = '0 meses'},
    {title = false, label = 'Art. 1.12 - Entrada en zona no autorizada.', price = 750, time = '8 meses'},
    {title = false, label = 'Art. 1.13 - Conducir sin licencia correspondiente del vehículo.', price = 1500, time = '8 meses'},
    {title = false, label = 'Art. 1.14 - Circular sin el casco en vehículos.', price = 300, time = '0 meses'},
    {title = false, label = 'Art. 1.15 - Saltarse un control de tráfico.', price = 800, time = '5 meses'},
    {title = false, label = 'Art. 1.16 - Falsificación de documentación de vehículo.', price = 600, time = '5 meses'},
    {title = false, label = 'Art. 1.17 - Superar límite de velocidad en vía urbana.', price = 700, time = '0 meses'},
    {title = false, label = 'Art. 1.18 - Circular con un vehículo no apto para la vía.', price = 1000, time = '0 meses'},
    {title = false, label = 'Art. 1.19 - Superar el límite de velocidad en vías secundarias.', price = 575, time = '0 meses'},
    {title = false, label = 'Art. 1.20 - Superar el límite de velocidad en autopistas.', price = 750, time = '0 meses'},
    {title = false, label = 'Art. 1.21 - Rebasar una línea continua.', price = 270, time = '0 meses'},
    {title = false, label = 'Art. 1.22 - Adelantamiento en línea continua.', price = 325, time = '0 meses'},
    {title = false, label = 'Art. 1.23 - No parar en una señal de Stop.', price = 275, time = '0 meses'},
    {title = false, label = 'Art. 1.24 - Conducir bajo los efectos del alcohol', price = 500, time = '0 meses'},
    {title = false, label = 'Art. 1.25 - Conducir bajo los efectos de sustancias estupefacientes.', price = 750, time = '5 meses'},
    {title = false, label = 'Art. 1.26 - No respetar el paso de peatones.', price = 350, time = '0 meses'},
    {title = false, label = 'Art. 1.27 - Usar el móvil siendo conductor.', price = 250, time = '0 meses'},
    {title = false, label = 'Art. 1.28 - No usar las luces correspondientes en vía pública.', price = 275, time = '0 meses'},
    {title = false, label = 'Art. 1.29 - No ceder la prioridad a los servicios de emergencia.', price = 630, time = '0 meses'},
    {title = false, label = 'Art. 1.30 - Obstrucción del tráfico', price = 630, time = '0 meses'},


    {title = true, label = 'Capítulo II - Agresiones, disturbios y conductas erróneas'},

    
    {title = false, label = 'Art. 2.01 - Disturbios en la vía publica', price = 1000, time = '0 meses'},
    {title = false, label = 'Art. 2.02 - Agresión a un civil.', price = 2000, time = '0 meses'},
    {title = false, label = 'Art. 2.03 - Faltas de respeto a un civil.', price = 500, time = '0 meses'},
    {title = false, label = 'Art. 2.04 - Amenaza verbal a un civil.', price = 750, time = '0 meses'},
    {title = false, label = 'Art. 2.05 - Agresión sexual.', price = 1500, time = '5 meses'},
    {title = false, label = 'Art. 2.06 - Alteración del orden público.', price = 750, time = '5 meses'},
    {title = false, label = 'Art. 2.07 - Prostitución en la vía pública.', price = 800, time = '5 meses'},
    {title = false, label = 'Art. 2.08 - Intento de violación.', price = 2500, time = '20 meses'},
    {title = false, label = 'Art. 2.09 - Violación.', price = 5000, time = '30 meses'},
    {title = false, label = 'Art. 2.10 - Violación a un menor de edad.', price = 5000, time = '60 meses'},
    {title = false, label = 'Art. 2.11 - Comercialización ilegal.', price = 550, time = '0 meses'},
    {title = false, label = 'Art. 2.12 - Manifestación ilegal.', price = 1500, time = '0 meses'},
    {title = false, label = 'Art. 2.13 - Dañar mobiliario urbano.', price = 875, time = '0 meses'},
    {title = false, label = 'Art. 2.14 - Acoso psicológico.', price = 2000, time = '10 meses'},
    {title = false, label = 'Art. 2.15 - Acoso sexual.', price = 5000, time = '10 meses'},
    {title = false, label = 'Art. 2.16 - Suplantación de identidad.', price = 4500, time = '5 meses'},
    {title = false, label = 'Art. 2.17 - Racismo.', price = 800, time = '0 meses'},
    {title = false, label = 'Art. 2.18 - Homofobia.', price = 800, time = '0 meses'},
    {title = false, label = 'Art. 2.19 - Circular por la vía pública con rostro oculto.', price = 520, time = '0 meses'},
    {title = false, label = 'Art. 2.20 - Circular por la vía pública desnudo o semidesnudo.', price = 520, time = '0 meses'},
    {title = false, label = 'Art. 2.21 - Circular por la vía pública sin camiseta.', price = 500, time = '0 meses'},
    {title = false, label = 'Art. 2.22 - Circular por la vía pública portando un chaleco antibalas.', price = 400, time = '0 meses'},
    {title = false, label = 'Art. 2.23 - Negación a identificarse.', price = 3200, time = '6 meses'},
    {title = false, label = 'Art. 2.24 - Obstrucción de la justicia.', price = 1500, time = '10 meses'},
    {title = false, label = 'Art. 2.25 - Violar un perímetro o un cordón policial.', price = 3000, time = '5 meses'},
    {title = false, label = 'Art. 2.26 - Delito de daños dolosos.', price = 750, time = '0 meses'},
    {title = false, label = 'Art. 2.27 - Delito de daños imprudentes.', price = 400, time = '0 meses'},
    {title = false, label = 'Art. 2.28 - Violar una orden de alejamiento dictada con sentencia firme.', price = 1000, time = '10 meses'},
    {title = false, label = 'Art. 2.29 - Allanamiento de morada.', price = 3500, time = '10 meses'},
    {title = false, label = 'Art. 2.30 - Participación en carreras ilícitas.', price = 920, time = '6 meses'},
    {title = false, label = 'Art. 2.31 - Violar el derecho de privacidad de un ciudadano.', price = 10000, time = '10 meses'},
    {title = false, label = 'Art. 2.32 - Faltas de respeto a un funcionario publico.', price = 600, time = '0 meses'},
    {title = false, label = 'Art. 2.33 - Amenaza verbal a un funcionario publico', price = 750, time = '5 meses'},
    {title = false, label = 'Art. 7.1 - Robo de vehículo.', price = 1800, time = '5 meses'},


    {title = true, label = 'Capítulo III - Robos y Asaltos'},


    {title = false, label = 'Art. 7.2 - Robo de vehículo de importación.', price = 2000, time = '10 meses'},
    {title = false, label = 'Art. 7.3 - Asalto a un civil.', price = 1700, time = '10 meses'},
    {title = false, label = 'Art. 7.4 - Hurto', price = 2000, time = '5 meses'},
    {title = false, label = 'Art. 7.5 - Robo a un establecimiento comercial.', price = 4000, time = '10 meses'},
    {title = false, label = 'Art. 7.5.1 - Robo a un establecimiento comercial con intento de homicidio.', price = 6500, time = '15 meses'},
    {title = false, label = 'Art. 7.5.2 - Intento de robo a un establecimiento comercial.', price = 3000, time = '5 meses'},
    {title = false, label = 'Art. 7.5.3 - Cómplice de robo.', price = 3000, time = '5 meses'},
    {title = false, label = 'Art. 7.6 Robo a Joyeria', price = 3000, time = '10 meses'},
    {title = false, label = 'Art. 7.7 Robo a Yate', price = 3500, time = '20 meses'},
    {title = false, label = 'Art. 7.8 Robo a Ammu-Nation', price = 8000, time = '10 meses'},
    {title = false, label = 'Art. 7.9 Robo a Reserva Federal', price = 20000, time = '25 meses'},
    {title = false, label = 'Art. 7.9 Robo a Establecimientos Bancarios', price = 15000, time = '15 meses'},


    {title = true, label = 'Capítulo IV - Tenencias de armas y objetos ilegales.'},


    {title = false, label = 'Art. 4.01 - Posesión de un arma blanca ilegal en vía pública.', price = 1500, time = '0 meses'},
    {title = false, label = 'Art. 4.02 - Exhibición de un arma blanca ilegal en vía pública.', price = 1750, time = '0 meses'},
    {title = false, label = 'Art. 4.03 - Posesión de un arma ilegal en vía pública.', price = 3100, time = '6 meses'},
    {title = false, label = 'Art. 4.04 - Exhibición de un arma blanca ilegal en vía pública.', price = 3310, time = '7 meses'},
    {title = false, label = 'Art. 4.05 - Posesión de un arma ilegal de fuego (de bajo calibre).', price = 7000, time = '10 meses'},
    {title = false, label = 'Art. 4.06 - Posesión de un arma ilegal de fuego (automáticas de medio calibre).', price = 12000, time = '14 meses'},
    {title = false, label = 'Art. 4.07 - Posesión de un arma ilegal de fuego (automáticas de alto calibre).', price = 20000, time = '20 meses'},
    {title = false, label = 'Art. 4.08 - Exhibición de un arma ilegal de fuego (de bajo calibre).', price = 7500, time = '12 meses'},
    {title = false, label = 'Art. 4.09 - Exhibición de un arma ilegal de fuego (automáticas de medio calibre).', price = 12500, time = '16 meses'},
    {title = false, label = 'Art. 4.10 - Exhibición de un arma ilegal de fuego (automáticas de alto calibre).', price = 21000, time = '22 meses'},
    {title = false, label = 'Art. 4.11 - Posesión de herramientas de robo.', price = 3750, time = '7 meses'},
    {title = false, label = 'Art. 4.12 - Posesión de herramientas explosivas.', price = 4200, time = '10 meses'},
    {title = false, label = 'Art. 4.13 - Posesión de munición y accesorios ilegales.', price = 20, time = '0 meses'},
    {title = false, label = 'Art. 4.14 - Tráfico de armas.', price = 30000, time = '30 meses'},


    {title = true, label = 'Capítulo V - Posesión y Tráfico de divisas.'},


    {title = false, label = 'Art. 5.01 - Posesión de dinero negro $1 - $5000', price = 2000, time = '0 meses'},
    {title = false, label = 'Art. 5.02 - Posesión de dinero negro $5001 - $10000', price = 6000, time = '6 meses'},
    {title = false, label = 'Art. 5.03 - Posesión de dinero negro $10001 - $30000', price = 12000, time = '15 meses'},
    {title = false, label = 'Art. 5.04 - Tráfico de divisas.', price = 25000, time = '30 meses'},
    {title = false, label = 'Art. 5.05 - Posesión de joyas ilegales.', price = 5000, time = '10 meses'},
    {title = false, label = 'Art. 5.06 - Venta de joyas ilegales.', price = 10000, time = '20 meses'},


    {title = true, label = 'Capítulo VI - Delitos contra la Salud Pública.'},


    {title = false, label = 'Art. 6.01 - Posesión de marihuana.', price = 400, time = '0 meses'},
    {title = false, label = 'Art. 6.02 - Posesión de opio.', price = 100, time = '0 meses'},
    {title = false, label = 'Art. 6.03 - Posesión de hachís.', price = 300, time = '0 meses'},
    {title = false, label = 'Art. 6.04 - Posesión de MDMA en pastillas (Extasis).', price = 150, time = '0 meses'},
    {title = false, label = 'Art. 6.04.1 - Posesión de MDMA en botes (Extaxis).', price = 1500, time = '0 meses'},
    {title = false, label = 'Art. 6.05 - Posesión de cocacína.', price = 600, time = '0 meses'},
    {title = false, label = 'Art. 6.06 - Venta de drogas.', price = 2000, time = '10 meses'},
    {title = false, label = 'Art. 6.07 - Tráfico de drogas.', price = 4000, time = '20 meses'},


    {title = true, label = 'Capítulo VII - Delitos contra la Integridad del Ciudadano.'},


    {title = false, label = 'Art. 7.01 - Intento de secuestro de un civil.', price = 2500, time = '7 meses'},
    {title = false, label = 'Art. 7.02 - Secuestro de un civil.', price = 5000, time = '10 meses'},
    {title = false, label = 'Art. 7.03.1 - Intento de homicidio en tercer grado.', price = 6125, time = '10 meses'},
    {title = false, label = 'Art. 7.03.2 - Intento de homicidio en segundo grado.', price = 7250, time = '15 meses'},
    {title = false, label = 'Art. 7.03.3 - Intento de homicidio en primer grado.', price = 12500, time = '17 meses'},
    {title = false, label = 'Art. 7.04.1 - Homicidio en tercer grado.', price = 12500, time = '17 meses'},
    {title = false, label = 'Art. 7.04.2 - Homicidio en segundo grado.', price = 15500, time = '20 meses'},
    {title = false, label = 'Art. 7.04.4 - Homicidio en primer grado.', price = 17500, time = '25 meses'},
    {title = false, label = 'Art. 7.05 - Asesinato en primer grado.', price = 20000, time = '30 meses'},
    {title = false, label = 'Art. 7.06 - Agresión mediante armas a un civil.', price = 2000, time = '5 meses'},
    {title = false, label = 'Art. 7.07 - Amenaza o extorsión a un ciudadano.', price = 3000, time = '7 meses'},
    {title = false, label = 'Art. 7.08 - Amenaza o extorsión a un ciudadano mediante uso de arma.', price = 3500, time = '10 meses'},
    {title = false, label = 'Art. 7.09 - Omisión del deber de socorro.', price = 2100, time = '0 meses'},
    {title = false, label = 'Art. 7.10 - Cooperador / Inductor al intento de suicidio.', price = 3500, time = '12 meses'},
    {title = false, label = 'Art. 7.11 - Cooperador / Inductor al suicidio consumado.', price = 10000, time = '20 meses'},
    {title = false, label = 'Art. 7.12 - Neglicencia médica con resultado de lesiones.', price = 2500, time = '5 meses'},
    {title = false, label = 'Art. 7.13 - Negligencia médica con resultado de muerte', price = 10000, time = '20 meses'},


    {title = true, label = 'Capítulo VIII - Documentos y Licencias.'},


    {title = false, label = 'Art. 8.01 - Falsificación de documentos.', price = 4500, time = '8 meses'},
    {title = false, label = 'Art. 8.02 - Posesión de un documento falso.', price = 3000, time = '6 meses'},
    {title = false, label = 'Art. 8.03 - Estafa.', price = 2500, time = '10 meses'},
    {title = false, label = 'Art. 8.04 - Negación del agente a enseñar el número de placa.', price = 1000, time = '0 meses'},
    {title = false, label = 'Art. 8.05 - Denuncia Falsa, Escasa o Irrisoria.', price = 2000, time = '0 meses'},
    {title = false, label = 'Art. 8.06 - Poseer una documentación no renovada/válida.', price = 1000, time = '0 meses'},


    {title = true, label = 'Capítulo IX - Administración Pública.'},


    {title = false, label = 'Art. 9.01 - Desacato a la autoridad.', price = 1000, time = '0 meses'},
    {title = false, label = 'Art. 9.02 - Intento de Homicidio al Fiscal.', price = 100000, time = 'Perpetua'},
    {title = false, label = 'Art. 9.03 - Homicidio al Fiscal.', price = 100000, time = 'Perpetua'},
    {title = false, label = 'Art. 9.04 - Allanamiento de edificios/instalaciones Federales.', price = 12500, time = '20 meses'},
    {title = false, label = 'Art. 9.05 - Allanamiento de edificios/instalaciones Federales.', price = 12500, time = '20 meses'},
    {title = false, label = 'Art. 9.06 - Robo de elementos estatales.', price = 4500, time = '8 meses'},
    {title = false, label = 'Art. 9.07 - Hurto de elementos estatales.', price = 3500, time = '6 meses'},
    {title = false, label = 'Art. 9.08 - Robo de armamento estatal.', price = 12000, time = '20 meses'},
    {title = false, label = 'Art. 9.09 - Hurto de armamento estatal.', price = 7000, time = '15 meses'},
    {title = false, label = 'Art. 9.10 - Robo a un funcionario público.', price = 6500, time = '15 meses'},
    {title = false, label = 'Art. 9.11 - Resistencia al arresto.', price = 1200, time = '5 meses'},
    {title = false, label = 'Art. 9.12 - Intento de soborno.', price = 2500, time = '5 meses'},
    {title = false, label = 'Art. 9.13 - Soborno.', price = 4000, time = '7 meses'},
    {title = false, label = 'Art. 9.14 - Difamar o difundir grabaciones o fotografías de un funcionario público.', price = 3100, time = '0 meses'},
    {title = false, label = 'Art. 9.15 - Intento de secuestro a un funcionario público.', price = 5000, time = '15 meses'},
    {title = false, label = 'Art. 9.16 - Secuestro a un funcionario público.', price = 10000, time = '20 meses'},
    {title = false, label = 'Art. 9.17 - Huir de la justicia.', price = 3500, time = '7 meses'},
    {title = false, label = 'Art. 9.18 - Suplantación de identidad de un miembro del estado.', price = 10000, time = '10 meses'},
    {title = false, label = 'Art. 9.19 - Mentir o dar falso testimonio.', price = 4700, time = '7 meses'}
}

Config.Treatments = {
    {title = true, label = 'Seguro Médico'},

    {title = false, label = 'Seguro Mensual', price = 2500},
    {title = false, label = 'Seguro Anual', price = 20500},
    
    {title = true, label = 'Traslados'},

    {title = false, label = 'Traslado en ambulancia', price = 450},
    {title = false, label = 'Asistencia médica + Traslado en ambulancia', price = 650},
    {title = false, label = 'Recate + Traslado en ambulancia', price = 2050},
    
    {title = true, label = 'Tratamientos ambulatorios'},
    
    {title = false, label = 'Chequeo Médico', price = 450},
    {title = false, label = 'Vacunación', price = 250},
    {title = false, label = 'Tratamiento de Heridas leves', price = 250},
    {title = false, label = 'Analítica Completa', price = 250},


    {title = true, label = 'Tratamientos hospitalarios'},

    {title = false, label = 'Tratamiento de heridas por traumatismo medio', price = 550},
    {title = false, label = 'Sesión de Radioterapia', price = 1050},
    {title = false, label = 'Sesión de Quimioterapia', price = 1050},
    {title = false, label = 'Radiografía', price = 550},
    {title = false, label = 'Escaner TAC', price = 750},
    {title = false, label = 'Tratamiento de heridas por traumatismo grave', price = 2050},

    {title = true, label = 'Consultas Médicas'},

    {title = false, label = 'Consulta de Psiquiatria', price = 750},
    {title = false, label = 'Consulta de Urología', price = 750},
    {title = false, label = 'Consulta de Oncología', price = 750},
    {title = false, label = 'Consulta de Cirugía General', price = 750},
    {title = false, label = 'Consulta de Neurologia / Neurocirugia', price = 750},
    {title = false, label = 'Consulta de Medicina General', price = 750},


    {title = true, label = 'Intervenciones Quirurgicas'},

    {title = false, label = 'Cirugía Ambulatoria', price = 5000},
    {title = false, label = 'Cirugia Ósea', price = 7000},
    {title = false, label = 'Reconstrucción Ósea', price = 10000},
    {title = false, label = 'Cirugía Renal / Urológica', price = 12000},
    {title = false, label = 'Transplante Renal', price = 52000},
    {title = false, label = 'Transplante Hepático', price = 52000},
    {title = false, label = 'Cirugía Cardiovascular', price = 15000},
    {title = false, label = 'Neurocirugía', price = 25000},
    {title = false, label = 'Cirugía Torácica', price = 25000},
    {title = false, label = 'Transplante Cardiaco', price = 85000},
    {title = false, label = 'Broncoscopia Intervencionista', price = 15000},
    {title = false, label = 'Cirugía Pulmonar', price = 15000},
    {title = false, label = 'Cirugía Oncológica', price = 25000}
}

Config.MecaPrices = {
    {title = true, label = 'Titulo de Ejemplo'},
    {title = false, label = 'Precio de Ejemplo (modificar en el config.lua)', price = 1},
}