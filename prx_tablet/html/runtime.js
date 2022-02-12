document.onkeydown = function (data) {
    if ((data.which == 120 || data.which == 27)) { // || data.which == 8
        $.post('https://prx_tablet/cerrar_tablet');
    }
};

$(function (){
    window.addEventListener('message', function (event) {
        if(event.data.scale){
            document.getElementById('marco').style.scale =event.data.scale
        }
        if(event.data.abrir == true){
            $('#marco').fadeIn();
            $("#menu_imagen").attr("src", event.data.playerInfo.foto);
        }else if(event.data.abrir == false){
            $('#marco').fadeOut();
        }
        if(event.data.foundPlayers){ 
            $('#repers_content').html('')
            event.data.foundPlayers.forEach(function(user){
                $('#repers_content').append($('<tr>').append($('<td class="repers_content">').text(user['firstname']),
                $('<td class="repers_content">').text(user['lastname']),
                $('<td class="repers_content">').text(user['dateofbirth']),
                $('<td class="repers_content">').append($('<button class="boton_lateral" id="lspd_vm_button" style="position:relative;">Ver Más</button>').click(function(){
                    $.post('https://prx_tablet/get_other_person_info',JSON.stringify(user['identifier']));
                    $('.lspd_subApp').fadeOut();
                    $('#volver_perf_lspd').show();
                    $.post('https://prx_tablet/get_busqueda_list',JSON.stringify(user['identifier']));
                    $.post('https://prx_tablet/get_danger_list',JSON.stringify(user['identifier']));
                    $('.pop_up').fadeOut();
                    $('.lspd_perf_container_blat').hide();
                    $('.lspd_perf_tables').hide();
                    $('#volver_perf_lspd_veh').hide();
                    $('#lspd_perf_pers').fadeIn();
                    $('#lspd_perf_container_blat').hide();
                }))));
            })
        }
    
        if(event.data.foundVehicles){ 
            $('#reveh_content').html('')
            event.data.foundVehicles.forEach(function(user){
                $('#reveh_content').append($('<tr>').append($('<td class="reveh_content">').text(user['modelo']),
                $('<td class="reveh_content">').text(user['plate']),
                $('<td class="repers_content">').append($('<button class="boton_lateral" id="lspd_vm_button" style="position:relative;">Ir al Perfil del Propietario</button>').click(function(){
                    $.post('https://prx_tablet/get_other_person_info',JSON.stringify(user['identifier']));
                    $('.lspd_subApp').fadeOut();
                    $('.lspd_perf_tables').hide();
                    $.post('https://prx_tablet/get_busqueda_list',JSON.stringify(user['identifier']));
                    $.post('https://prx_tablet/get_danger_list',JSON.stringify(user['identifier']));
                    $('.lspd_perf_container_blat').hide();
                    $('#volver_perf_lspd').hide();
                    $('.pop_up').fadeOut();
                    $('#volver_perf_lspd_veh').show();
                    $('#lspd_perf_pers').fadeIn();
                }))));
            })
        }
        if(event.data.otherLInfo){
            $('#lspd_perf_nom').text('Nombre: '+event.data.otherLInfo.name);
            $('#lspd_perf_emp').text('Empleo: '+event.data.otherLInfo.job.label+' - '+event.data.otherLInfo.job.grade_label);
            $('#lspd_perf_est').text('Estatura: '+event.data.otherLInfo.estatura+' m');
            $('#lspd_perf_fecha').text('Fecha de Nacimiento: '+event.data.otherLInfo.fecha);
            $('#lspd_perf_tel').text('Teléfono: '+event.data.otherLInfo.phone);
            $("#lspd_plyFoto").attr("src", event.data.otherLInfo.foto);
            $("#lspd_perf_multas").text('Total multas sin pagar: '+ event.data.otherLInfo.sinPagar + ' $')
            if(event.data.otherLInfo.sex == 'm'){
                $('#lspd_perf_gen').text('Género: Masculino');
            }else{
                $('#lspd_perf_gen').text('Género: Femenino');
            }
        }
        if(event.data.codPenal){ 
            $('#lspd_cp_table').html('');    
            event.data.codPenal.forEach(function(cp){
                if(cp['title'] == true){
                $('#lspd_cp_table').append($('<tr>').append(
                    $('<td class="cp_table_title">').text(cp['label']),
                    $('<td class="cp_table_title">').text(' '),
                    $('<td class="cp_table_title">').text(' ')
                ));
                }else{
                $('#lspd_cp_table').append($('<tr>').append(
                    $('<td class="cp_table_content">').text(cp['label']),
                    $('<td class="cp_table_content">').text(cp['price']+' $'),
                    $('<td class="cp_table_content">').text(cp['time'])
                ));
                }
            });
        }
        if(event.data.multasList){
            $('#lspd_add_delito_content').html('');
            event.data.multasList.forEach(function(list){
                if(list['title'] == false){
                $('#lspd_add_delito_content').append($('<tr>').append(
                    $('<td class = "lspd_add_delito_content">').text(list['label']),
                    $('<td class = "lspd_add_delito_content">').text(list['price']+' $'),
                    $('<td class = "lspd_add_delito_content">').text(list['time']),
                    $('<td class = "lspd_add_delito_content">').append($('<button class = "boton_sup">Modificar</button>').click(function(){
                        $('#input_lspd_delitos_label').val(list['label']);
                        $('#input_lspd_delitos_price').val(list['price']);
                        $('#input_lspd_delitos_time').val(list['time']);
                    })
                    ),
                    $('<td class = "lspd_add_delito_content">').append($('<button style = "font-size:12px;" class = "boton_sup">Añadir Delito</button>').click(function(){
                        info = JSON.stringify({label: list['label'], price: list['price'], time: list['time']})
                        $.post('https://prx_tablet/add_delito', info);
                    })
                    ),
                ));
                }else{
                    $('#lspd_add_delito_content').append($('<tr>').append(
                        $('<td class = "lspd_add_delito_content" style = "padding:10px; font-weight: bolder; font-size:20px;">').text(list['label']),
                        $('<td class = "lspd_add_delito_content">'),
                        $('<td class = "lspd_add_delito_content">'),
                        $('<td class = "lspd_add_delito_content">'),
                        $('<td class = "lspd_add_delito_content">')
                    ));
                }
            });
        }
        if(event.data.vehicles){ 
            $('#veh_content').html('');
            event.data.vehicles.forEach(function(car){
                $('#veh_content').append($('<tr>').append(
                $('<td class="veh_content">').text(car['modelo']),
                $('<td class="veh_content">').text(car['plate']),
                $('<td class="veh_content">').text(car['garage'])));
            })
        }
    
        if(event.data.delitosPerfil){ 
            $('#delitos_content').html('');
            event.data.delitosPerfil.forEach(function(del){
                $('#delitos_content').append($('<tr>').append(
                $('<td class="delitos_content">').text(del['content']),
                $('<td class="delitos_content">').text(del['fine'] + ' $'),
                $('<td class="delitos_content">').text(del['time'] + ' meses')));
            })
        }
    
        if(event.data.otherVehicles){
            $('#lspd_veh_content').html('');
            event.data.otherVehicles.forEach(function(veh){
                $('#lspd_veh_content').append($('<tr>').append(
                    $('<td class = "lspd_veh_content">').text(veh['modelo']),
                    $('<td class = "lspd_veh_content">').text(veh['plate'])));
            });
        }
    
        if(event.data.otherHouseLabel){
            $('#lspd_prop_content').html('');
            event.data.otherHouseLabel.forEach(function(prop){
                $('#lspd_prop_content').append($('<tr>').append(
                    $('<td class = "lspd_prop_content">').text(prop['label'])));
            });
        }
    
        if(event.data.houseLabel){
            $('#prop_content').html('')
            event.data.houseLabel.forEach(function(house){
                $('#prop_content').append($('<tr>').append($('<td class="prop_content">').text(house['label'])));
            })
        }
    
        if(event.data.delitosPersona){
            $('#lspd_hist_content').html('');
            event.data.delitosPersona.forEach(function(delitos){
                $('#lspd_hist_content').append($('<tr>').append(
                    $('<td class = "lspd_hist_content">').text(delitos['content']),
                    $('<td class = "lspd_hist_content">').text(delitos['officer']),
                    $('<td class = "lspd_hist_content">').text(new Date(delitos['date']).toLocaleDateString("es-ES")),
                    $('<td class = "lspd_hist_content">').text(delitos['fine']+' $'),
                    $('<td class = "lspd_hist_content">').text(delitos['time']+' meses'),
                    $('<td class = "lspd_hist_content">').append('<button class = "boton_sup">Eliminar</button>').click(function(){
                        var info = JSON.stringify({date:delitos['date'],label:delitos['content'],officer:delitos['officer']});
                        $.post('https://prx_tablet/del_delito', info);
                    }),
                ));
            });
        }
    
        if(event.data.notasPersona){
            $('#lspd_notas_content').html('');
            event.data.notasPersona.forEach(function(notas){
                $('#lspd_notas_content').append($('<tr>').append(
                    $('<td class = "lspd_notas_content">').text(notas['note']),
                    $('<td class = "lspd_notas_content">').text(notas['officer']),
                    $('<td class = "lspd_notas_content">').text(new Date(notas['date']).toLocaleDateString("es-ES")),
                    $('<td class = "lspd_notas_content">').append('<button class = "boton_sup">Eliminar</button>').click(function(){
                        var info = JSON.stringify({date:notas['date'],label:notas['note'],officer:notas['officer']});
                        $.post('https://prx_tablet/del_nota', info);
                    }),
                ));
            });
        }
    
        if(event.data.busquedaPersona){
            if(event.data.busquedaPersona.inSearch == true){
                $('#input_lspd_busqueda').val(event.data.busquedaPersona.motivo);
                $('#lspd_perf_search').text('Sujeto en Busca y Captura: SI');
                $('#boton_editar_busca').fadeIn();
                $('#boton_poner_en_busca').hide();
            }else if(event.data.busquedaPersona.inSearch == false){
                $('#lspd_perf_search').text('Sujeto en Busca y Captura: NO');
                $('#input_lspd_busqueda').val('');
                $('#boton_poner_en_busca').fadeIn();
                $('#boton_editar_busca').hide();
            }
        }
    
        if(event.data.personaDanger){
            if(event.data.personaDanger.danger == true){
                $('#input_lspd_danger').val(event.data.personaDanger.motivo);
                $('#lspd_perf_danger').text('Sujeto Peligroso: SI');
                $('#boton_editar_danger').fadeIn();
                $('#boton_poner_danger').hide();
            }else if(event.data.personaDanger.danger == false){
                $('#lspd_perf_danger').text('Sujeto Peligroso: NO');
                $('#input_lspd_danger').val('');
                $('#boton_poner_danger').fadeIn();
                $('#boton_editar_danger').hide();
            }
        }
    
        if(event.data.allBusquedas){
            $('#lspd_buscaycap').html('');
            event.data.allBusquedas.forEach(function(info){
                $('#lspd_buscaycap').append(
                    $('<div class = "busqueda_container">').append(
                        $('<image class = "imagen_byq"></image>').attr("src", info['image']),
                        $('<br>'),
                        $('<h class="name_byq">').text(info['name']),
                        $('<br>'),
                        $('<button style="margin:10px;" class="boton_sup"><i class= "fas fa-id-card"></i> Ver Perfil</button>').click(function(){
                            $.post('https://prx_tablet/get_other_person_info',JSON.stringify(info['id']));
                            $('.lspd_subApp').fadeOut();
                            $('#volver_perf_lspd').hide();
                            $.post('https://prx_tablet/get_busqueda_list',JSON.stringify(info['id']));
                            $.post('https://prx_tablet/get_danger_list',JSON.stringify(info['id']));
                            $('.pop_up').fadeOut();
                            $('.lspd_perf_container_blat').hide();
                            $('#ems_perf_container_bsup').hide();
                            $('.lspd_perf_tables').hide();
                            $('#volver_perf_lspd_veh').hide();
                            $('#lspd_perf_pers').fadeIn();
                            $('#lspd_perf_container_blat').hide();
                        })
                ));
            });
        }
    
        if(event.data.tratamientos){ 
            $('#ems_trt_table').html('');    
            event.data.tratamientos.forEach(function(cp){
                if(cp['title'] == true){
                $('#ems_trt_table').append($('<tr>').append(
                    $('<td class="trt_table_title">').text(cp['label']),
                    $('<td class="trt_table_title">').text(' ')
                ));
                }else{
                $('#ems_trt_table').append($('<tr>').append(
                    $('<td class="trt_table_content">').text(cp['label']),
                    $('<td class="trt_table_content">').text(cp['price']+' $')
                ));
                }
            });
        }
    
        if(event.data.foundEMSPlayers){ 
            $('#ems_repers_content').html('')
            event.data.foundEMSPlayers.forEach(function(user){
                $('#ems_repers_content').append($('<tr>').append(
                $('<td class="repers_content">').text(user['firstname']),
                $('<td class="repers_content">').text(user['lastname']),
                $('<td class="repers_content">').text(user['dateofbirth']),
                $('<td class="repers_content">').append($('<button class="boton_lateral" id="ems_vm_button" style="position:relative;">Ver Más</button>').click(function(){
                    $.post('https://prx_tablet/ems_get_other_person_info',JSON.stringify(user['identifier']));
                    $('.ems_subApp').fadeOut();
                    $('#ems_perf_container_bsup').show();
                    $('.pop_up').fadeOut();
                    $('.ems_perf_tables').hide();
                    $('#ems_perf_pers').fadeIn();
                    $.post('https://prx_tablet/get_hist_ems',JSON.stringify(user['identifier']));
                }))));
            })
        }
    
        if(event.data.otherEMSLInfo){
            $('#ems_perf_nom').text('Nombre: '+event.data.otherEMSLInfo.name);
            $('#ems_perf_emp').text('Empleo: '+event.data.otherEMSLInfo.job.label+' - '+event.data.otherEMSLInfo.job.grade_label);
            $('#ems_perf_est').text('Estatura: '+event.data.otherEMSLInfo.estatura +' m');
            $('#ems_perf_fecha').text('Fecha de Nacimiento: '+event.data.otherEMSLInfo.fecha);
            $('#ems_perf_tel').text('Teléfono: '+event.data.otherEMSLInfo.phone);
            $("#ems_plyFoto").attr("src", event.data.otherEMSLInfo.foto);
            if(event.data.otherEMSLInfo.sex == 'm'){
                $('#ems_perf_gen').text('Género: Masculino');
            }else{
                $('#ems_perf_gen').text('Género: Femenino');
            }
        }
    
        if(event.data.tratsList){
            $('#ems_add_trat_content').html('');
            event.data.tratsList.forEach(function(list){
                if(list['title'] == false){
                $('#ems_add_trat_content').append($('<tr>').append(
                    $('<td class = "ems_add_trat_content">').text(list['label']),
                    $('<td class = "ems_add_trat_content">').text(list['price']+' $'),
                    $('<td class = "ems_add_trat_content">').append($('<button class = "boton_sup">Modificar</button>').click(function(){
                        $('#input_ems_trat_label').val(list['label']);
                        $('#input_ems_trat_price').val(list['price']);
                    })
                    ),
                    $('<td class = "ems_add_trat_content">').append($('<button style = "font-size:12px;" class = "boton_sup">Añadir</button>').click(function(){
                        info = JSON.stringify({label: list['label'], price: list['price']})
                        $.post('https://prx_tablet/add_trat', info);
                    })
                    ),
                ));
                }else{
                    $('#ems_add_trat_content').append($('<tr>').append(
                        $('<td class = "ems_add_trat_content" style = "padding:10px; font-weight: bolder; font-size:20px;">').text(list['label']),
                        $('<td class = "ems_add_trat_content">'),
                        $('<td class = "ems_add_trat_content">'),
                        $('<td class = "ems_add_trat_content">')
                    ));
                }
            });
        }
    
        if(event.data.histmedicoPersona){
            $('#ems_hist_content').html('');
            event.data.histmedicoPersona.forEach(function(delitos){
                $('#ems_hist_content').append($('<tr>').append(
                    $('<td class = "ems_hist_content">').text(delitos['label']),
                    $('<td class = "ems_hist_content">').text(delitos['doctor']),
                    $('<td class = "ems_hist_content">').text(new Date(delitos['date']).toLocaleDateString("es-ES")),
                    $('<td class = "ems_hist_content">').text(delitos['price']+' $'),
                    $('<td class = "ems_hist_content">').append('<button class = "boton_sup">Eliminar</button>').click(function(){
                        var info = JSON.stringify({date:delitos['date'],label:delitos['label'],officer:delitos['doctor']});
                        $.post('https://prx_tablet/del_hist_ems', info);
                    }),
                ));
            });
        }
    
        if(event.data.medicoPerfil){ 
            $('#med_content').html('');
            event.data.medicoPerfil.forEach(function(del){
                $('#med_content').append($('<tr>').append(
                $('<td class="med_content">').text(del['label']),
                $('<td class="med_content">').text(del['price'] + ' $')));
            })
        }
    
        if(event.data.notasEMSPersona){
            $('#ems_notes_content').html('');
            event.data.notasEMSPersona.forEach(function(notas){
                $('#ems_notes_content').append($('<tr>').append(
                    $('<td class = "ems_notes_content">').text(notas['label']),
                    $('<td class = "ems_notes_content">').text(notas['sender']),
                    $('<td class = "ems_notes_content">').text(new Date(notas['date']).toLocaleDateString("es-ES")),
                    $('<td class = "ems_notes_content">').append('<button class = "boton_sup">Eliminar</button>').click(function(){
                        var info = JSON.stringify({date:notas['date'],label:notas['label'],sender:notas['sender']});
                        $.post('https://prx_tablet/del_nota_ems', info);
                    }),
                ));
            });
        }

        if(event.data.trabajadores){
            $('#g_empleados_content').html('');
            event.data.trabajadores.forEach(function(workers){
                var info = JSON.stringify(workers)
                $('#g_empleados_content').append($(`<div class ="g_content">${workers.job.label} | ${workers.user.firstname} ${workers.user.lastname}</div>`).append(
                    $('<button class="boton_sup" style="margin:3px; font-size:10px;">Despedir</button>').click(function(){
                        $.post('https://prx_tablet/despedir', info)
                    }),
                    $('<button class="boton_sup" style="margin:3px; font-size:10px;">Ascender</button>').click(function(){
                        $.post('https://prx_tablet/ascender', info)
                    }),
                    $('<button class="boton_sup" style="margin:3px; font-size:10px;">Degradar</button>').click(function(){
                        $.post('https://prx_tablet/degradar', info)
                    })
                ));
            });
        }

        if(event.data.stockItems){
            $('#g_items_content').html('');
            event.data.stockItems.forEach(function(item){
                $('#g_items_content').append($(`<div class ="g_content"><image onerror="this.style.display=\'none\'" style="height:20px; width:auto;" src="https://raw.githubusercontent.com/ivanprogamer43/inventory-images/main/${item.name}.png"/> ${item.label} x  ${item.count}</div>`).append(
                ))
            });
        }
    
        if(event.data.preciosMeca){ 
            $('#meca_trt_table').html('');    
            event.data.preciosMeca.forEach(function(cp){
                if(cp['title'] == true){
                $('#meca_trt_table').append($('<tr>').append(
                    $('<td class="trt_table_title">').text(cp['label']),
                    $('<td class="trt_table_title">').text(' ')
                ));
                }else{
                $('#meca_trt_table').append($('<tr>').append(
                    $('<td class="trt_table_content">').text(cp['label']),
                    $('<td class="trt_table_content">').text(cp['price']+' $')
                ));
                }
            });
        }
        
        if(event.data.foundmecaPlayers){ 
            $('#meca_repers_content').html('')
            event.data.foundmecaPlayers.forEach(function(user){
                $('#meca_repers_content').append($('<tr>').append(
                $('<td class="repers_content">').text(user['firstname']),
                $('<td class="repers_content">').text(user['lastname']),
                $('<td class="repers_content">').text(user['dateofbirth']),
                $('<td class="repers_content">').append($('<button class="boton_lateral" id="meca_vm_button" style="position:relative;">Ver Más</button>').click(function(){
                    $.post('https://prx_tablet/meca_get_other_person_info',JSON.stringify(user['identifier']));
                    $('.meca_subApp').fadeOut();
                    $('#meca_perf_container_bsup').show();
                    $('.pop_up').fadeOut();
                    $('.meca_perf_tables').hide();
                    $('#meca_perf_pers').fadeIn();
                    $.post('https://prx_tablet/get_hist_meca',JSON.stringify(user['identifier']));
                }))));
            })
        }
        
        if(event.data.othermecaLInfo){
            $('#meca_perf_nom').text('Nombre: '+event.data.othermecaLInfo.name);
            $('#meca_perf_emp').text('Empleo: '+event.data.othermecaLInfo.job.label+' - '+event.data.othermecaLInfo.job.grade_label);
            $('#meca_perf_est').text('Estatura: '+event.data.othermecaLInfo.estatura +' m');
            $('#meca_perf_fecha').text('Fecha de Nacimiento: '+event.data.othermecaLInfo.fecha);
            $('#meca_perf_tel').text('Teléfono: '+event.data.othermecaLInfo.phone);
            $("#meca_plyFoto").attr("src", event.data.othermecaLInfo.foto);
            if(event.data.othermecaLInfo.sex == 'm'){
                $('#meca_perf_gen').text('Género: Masculino');
            }else{
                $('#meca_perf_gen').text('Género: Femenino');
            }
        }
        
        if(event.data.preciosMecaList){
            $('#meca_add_trat_content').html('');
            event.data.preciosMecaList.forEach(function(list){
                if(list['title'] == false){
                $('#meca_add_trat_content').append($('<tr>').append(
                    $('<td class = "meca_add_trat_content">').text(list['label']),
                    $('<td class = "meca_add_trat_content">').text(list['price']+' $'),
                    $('<td class = "meca_add_trat_content">').append($('<button class = "boton_sup">Modificar</button>').click(function(){
                        $('#input_meca_trat_label').val(list['label']);
                        $('#input_meca_trat_price').val(list['price']);
                    })
                    ),
                    $('<td class = "meca_add_trat_content">').append($('<button style = "font-size:12px;" class = "boton_sup">Añadir</button>').click(function(){
                        info = JSON.stringify({label: list['label'], price: list['price']})
                        $.post('https://prx_tablet/add_fine', info);
                    })
                    ),
                ));
                }else{
                    $('#meca_add_trat_content').append($('<tr>').append(
                        $('<td class = "meca_add_trat_content" style = "padding:10px; font-weight: bolder; font-size:20px;">').text(list['label']),
                        $('<td class = "meca_add_trat_content">'),
                        $('<td class = "meca_add_trat_content">'),
                        $('<td class = "meca_add_trat_content">')
                    ));
                }
            });
        }
        
        if(event.data.histmecanicoPersona){
            $('#meca_hist_content').html('');
            event.data.histmecanicoPersona.forEach(function(delitos){
                $('#meca_hist_content').append($('<tr>').append(
                    $('<td class = "meca_hist_content">').text(delitos['label']),
                    $('<td class = "meca_hist_content">').text(delitos['doctor']),
                    $('<td class = "meca_hist_content">').text(new Date(delitos['date']).toLocaleDateString("es-ES")),
                    $('<td class = "meca_hist_content">').text(delitos['price']+' $'),
                    $('<td class = "meca_hist_content">').append('<button class = "boton_sup">Eliminar</button>').click(function(){
                        var info = JSON.stringify({date:delitos['date'],label:delitos['label'],officer:delitos['doctor']});
                        $.post('https://prx_tablet/del_hist_meca', info);
                    }),
                ));
            });
        }
        
        if(event.data.mecanicoPerfil){ 
            $('#med_content').html('');
            event.data.mecanicoPerfil.forEach(function(del){
                $('#med_content').append($('<tr>').append(
                $('<td class="med_content">').text(del['label']),
                $('<td class="med_content">').text(del['price'] + ' $')));
            })
        }
        
        if(event.data.notasmecaPersona){
            $('#meca_notes_content').html('');
            event.data.notasmecaPersona.forEach(function(notas){
                $('#meca_notes_content').append($('<tr>').append(
                    $('<td class = "meca_notes_content">').text(notas['label']),
                    $('<td class = "meca_notes_content">').text(notas['sender']),
                    $('<td class = "meca_notes_content">').text(new Date(notas['date']).toLocaleDateString("es-ES")),
                    $('<td class = "meca_notes_content">').append('<button class = "boton_sup">Eliminar</button>').click(function(){
                        var info = JSON.stringify({date:notas['date'],label:notas['label'],sender:notas['sender']});
                        $.post('https://prx_tablet/del_nota_meca', info);
                    }),
                ));
            });
        }


        if(event.data.playerInfo.job.name == 'police'){
            $('.boton_lateral').hide();
            $('#boton_lspd').show();
            $('#boton_perfil').show();
            $('#boton_salir').show();
            $('#boton_ajustes').show();  
        }else if(event.data.playerInfo.job.name == 'ambulance'){
            $('.boton_lateral').hide();
            $('#boton_ems').show();
            $('#boton_perfil').show();
            $('#boton_salir').show(); 
            $('#boton_ajustes').show();     
        }else if(event.data.playerInfo.job.name == 'mechanic'){
            $('.boton_lateral').hide();
            $('#boton_meca').show();
            $('#boton_perfil').show();
            $('#boton_salir').show();
            $('#boton_ajustes').show();
        }else{
            $('.boton_lateral').hide();
            $('#boton_perfil').show();
            $('#boton_salir').show();  
            $('#boton_ajustes').show();  
        }
    
        if(event.data.playerInfo.job.grade_name == 'boss'){
            $('#boton_gestion').show();
        }else{
            $('#boton_gestion').hide();
        }


        $('#boton_perfil').click(function(){
            $('.app').hide();
            $('#app_perfil').fadeIn();
            $('#perf_nom').text('Nombre: '+event.data.playerInfo.name);
            $('#perf_emp').text('Empleo: '+event.data.playerInfo.job.label+' - '+event.data.playerInfo.job.grade_label);
            $('#perf_est').text('Estatura: '+event.data.playerInfo.estatura+' m');
            $('#perf_fecha').text('Fecha de Nacimiento: '+event.data.playerInfo.fecha);
            $('#perf_tel').text('Teléfono: '+event.data.playerInfo.phone);
            if(event.data.playerInfo.sex == 'm'){
                $('#perf_gen').text('Género: Masculino');
            }else{
                $('#perf_gen').text('Género: Femenino');
            }
            if(event.data.vip == true){
                if(event.data.playerInfo.vip == true){
                    $('#vip').text('VIP: es VIP');
                }else{
                    $('#vip').text('VIP: no es VIP');
                }
            }else{
                $('#vip').text('');
            }
        });
        
    });
    $('#boton_salir').click(function(){
        $.post('https://prx_tablet/cerrar_tablet');
    });
    $('#perf_veh').click(function(){
        $('.table').hide();
        $('#container_vehicles').fadeIn();
        $.post('https://prx_tablet/get_owned_vehicles');
    });
    $('#perf_prop').click(function(){
        $('.table').hide();
        $('#container_properties').fadeIn();
        $.post('https://prx_tablet/get_owned_houses');
    });
    $('#perf_hist').click(function(){
        $('.table').hide();
        $('#container_delitos').fadeIn();
        $.post('https://prx_tablet/get_delitos_perf');
    });

    $('#boton_lspd').click(function(){
        $('.app').hide();
        $('.lspd_subApp').hide();
        $('#app_lspd').fadeIn();
        $('#lspd_princ').fadeIn();
    });

    $('#boton_gestion').click(function(){
        $('.app').hide();
        $('#app_gestion_empresas').fadeIn();
        $.post('https://prx_tablet/get_info_empresa')
    });

    $('#lspd_bfichar').click(function(){
        $('#lspd_princ').fadeOut();
        $('#lspd_fichar').fadeIn();
    });

    $('#lspd_bpers').click(function(){
        $('#lspd_princ').fadeOut();
        $('#lspd_buscar_pers').fadeIn();
    });

    $('#lspd_bpers_search').click(function(){
        $('#repers_content').html('');
        var boxContent = $('#input_lspd_bpers').val();
        $.post('https://prx_tablet/lspd_search_person',JSON.stringify(boxContent));
    });

    $('#lspd_actFoto').click(function(){
        var boxContent = $('#input_lspd_actfoto').val();
        $("#lspd_plyFoto").attr("src", boxContent);
        $.post('https://prx_tablet/lspd_act_foto',JSON.stringify(boxContent));
    });

    $('#volver_perf_lspd').click(function(){
        $('#lspd_perf_pers').fadeOut();
        $('.pop_up').fadeOut();
        $('#lspd_buscar_pers').fadeIn();
    });

    $('#volver_perf_lspd_veh').click(function(){
        $('#lspd_perf_pers').fadeOut();
        $('.pop_up').fadeOut();
        $('#lspd_buscar_veh').fadeIn();
    });

    $('#lspd_bveh').click(function(){
        $('#lspd_princ').fadeOut();
        $('#lspd_buscar_veh').fadeIn();
    });

    $('#lspd_bveh_search').click(function(){
        $('#reveh_content').html('');
        var boxContent = $('#input_lspd_bveh').val();
        $.post('https://prx_tablet/lspd_search_car',JSON.stringify(boxContent));
    });
    $('#lspd_perf_hist').click(function(){
        $('#lspd_perf_añadir_nota').hide();
        $('#lspd_perf_añadir_del').show();
        $('#lspd_perf_container_blat').fadeIn();
        $('.lspd_perf_tables').hide();
        $('#lspd_tabla_hist').fadeIn();
        $.post('https://prx_tablet/get_delitos');
    });
    $('#lspd_perf_notas').click(function(){
        $('#lspd_perf_añadir_nota').show();
        $('#lspd_perf_añadir_del').hide();
        $('#lspd_perf_container_blat').fadeIn();
        $('.lspd_perf_tables').hide();
        $('#lspd_tabla_notas').fadeIn();
        $.post('https://prx_tablet/get_notas');
    });
    $('#lspd_perf_veh').click(function(){
        $('#lspd_perf_container_blat').fadeOut();
        $('.lspd_perf_tables').hide();
        $('#lspd_tabla_veh').fadeIn();
        $.post('https://prx_tablet/lspd_get_veh');
    });
    $('#lspd_perf_prop').click(function(){
        $('#lspd_perf_container_blat').fadeOut();
        $('.lspd_perf_tables').hide();
        $('#lspd_tabla_prop').fadeIn();
        $.post('https://prx_tablet/lspd_get_prop');
    });
    $('#lspd_cpenal').click(function(){
        $('#lspd_princ').fadeOut();
        $('#lspd_cod_penal').fadeIn();
        $.post('https://prx_tablet/lspd_get_pc');
    });

    $('#search_cp_lspd').click(function(){
        var boxContent = $('#input_lspd_cp').val();
        $.post('https://prx_tablet/search_cp',JSON.stringify(boxContent));
    });

    $('#lspd_perf_añadir_del').click(function(){
        $('.pop_up').hide();
        $('#popUp_nuevo_delito').fadeIn();
        $.post('https://prx_tablet/lspd_get_list_multas');
    });

    $('#lspd_perf_añadir_nota').click(function(){
        $('.pop_up').hide();
        $('#popUp_nueva_nota').fadeIn();
    });

    $('.close_pop_up').click(function(){
        $('.pop_up').fadeOut();
    });

    $('#search_delitos_lspd').click(function(){
        var boxContent = $('#input_lspd_delitos_search').val();
        $.post('https://prx_tablet/search_delitos',JSON.stringify(boxContent));
    });

    $('#done_delitos_lspd').click(function(){
        var label = $('#input_lspd_delitos_label').val();
        var price = $('#input_lspd_delitos_price').val();
        var time = $('#input_lspd_delitos_time').val();
        var info = JSON.stringify({label:label,price:price,time:time});
        if(label != '' && price != '' && time != ''){
            $.post('https://prx_tablet/add_delito', info);
        }
        $('#input_lspd_delitos_label').val('');
        $('#input_lspd_delitos_price').val('');
        $('#input_lspd_delitos_time').val('');
    });

    $('#done_nota_lspd').click(function(){
        var label = $('#input_lspd_nota').val();
        if(label != ''){
            $.post('https://prx_tablet/add_nota', JSON.stringify(label));
        }
        $('#input_lspd_nota').val('');
    });

    $('#boton_poner_en_busca').click(function(){
        $('.pop_up').hide();
        $('#popUp_busca').fadeIn();
        $('#eliminar_busqueda_lspd').hide();
    });
    $('#boton_poner_danger').click(function(){
        $('.pop_up').hide();
        $('#popUp_danger').fadeIn();
        $('#eliminar_danger_lspd').hide();
    });

    $('#boton_editar_busca').click(function(){
        $('.pop_up').hide();
        $('#popUp_busca').fadeIn();
        $('#eliminar_busqueda_lspd').show();
    });

    $('#eliminar_busqueda_lspd').click(function(){
        $.post('https://prx_tablet/delete_busqueda');
    });
    $('#boton_editar_danger').click(function(){
        $('.pop_up').hide();
        $('#popUp_danger').fadeIn();
        $('#eliminar_danger_lspd').show();
    });

    $('#done_busqueda_lspd').click(function(){
        var boxContent = $('#input_lspd_busqueda').val();
        $.post('https://prx_tablet/add_busqueda',JSON.stringify(boxContent));
    });

    $('#done_danger_lspd').click(function(){
        var boxContent = $('#input_lspd_danger').val();
        $.post('https://prx_tablet/add_danger',JSON.stringify(boxContent));
    });

    $('#eliminar_danger_lspd').click(function(){
        $.post('https://prx_tablet/delete_danger');
    });

    $('#lspd_busqcap').click(function(){
        $('#lspd_princ').fadeOut();
        $('#lspd_buscaycap').fadeIn();
        $.post('https://prx_tablet/get_all_byq')
    });




    $('#boton_ems').click(function(){
        $('.app').hide();
        $('.ems_subApp').hide();
        $('#app_ems').fadeIn();
        $('#ems_princ').fadeIn();
    });

    $('#ems_bfichar').click(function(){
        $('#ems_princ').fadeOut();
        $('#ems_fichar').fadeIn();
    });

    $('#ems_bpers').click(function(){
        $('#ems_princ').fadeOut();
        $('#ems_buscar_pers').fadeIn();
    });

    $('#ems_btrt').click(function(){
        $('#ems_princ').fadeOut();
        $('#ems_tratamientos').fadeIn();
        $.post('https://prx_tablet/ems_get_trt');
    });

    $('#search_trt_ems').click(function(){
        var boxContent = $('#input_ems_trt').val();
        $.post('https://prx_tablet/search_trt',JSON.stringify(boxContent));
    });

    $('#ems_bpers_search').click(function(){
        $('#repers_content').html('');
        var boxContent = $('#input_ems_bpers').val();
        $.post('https://prx_tablet/ems_search_person',JSON.stringify(boxContent));
    });

    $('#volver_perf_ems').click(function(){
        $('#ems_perf_pers').fadeOut();
        $('.pop_up').fadeOut();
        $('#ems_perf_container_blat').hide();
        $('#ems_buscar_pers').fadeIn();
    });

    $('#ems_perf_añadir_trat').click(function(){
        $('.pop_up').hide();
        $('#popUp_nuevo_trat').fadeIn();
        $.post('https://prx_tablet/ems_get_list_trats');
    });
    $('#search_trat_ems').click(function(){
        var boxContent = $('#input_ems_trat_search').val();
        $.post('https://prx_tablet/search_trats',JSON.stringify(boxContent));
    });

    $('#done_trat_ems').click(function(){
        var label = $('#input_ems_trat_label').val();
        var price = $('#input_ems_trat_price').val();
        var info = JSON.stringify({label:label,price:price});
        if(label != '' && price != ''){
            $.post('https://prx_tablet/add_trat', info);
        }
        $('#input_ems_trat_label').val('');
        $('#input_ems_trat_price').val('');
    });

    $('#perf_ems').click(function(){
        $('.table').hide();
        $('#container_historial_med').fadeIn();
        $.post('https://prx_tablet/get_hist_ems_perf')
    });

    $('#ems_perf_hist').click(function(){
        $('.ems_perf_tables').hide();
        $('#ems_tabla_hist').fadeIn();
        $('#ems_perf_container_blat').show();
        $('#ems_perf_añadir_trat').fadeIn();
        $('#ems_perf_añadir_nota').hide();
    });
    $('#ems_perf_notas').click(function(){
        $('.ems_perf_tables').hide();
        $('#ems_tabla_notes').fadeIn();
        $('#ems_perf_container_blat').show();
        $('#ems_perf_añadir_trat').hide();
        $('#ems_perf_añadir_nota').fadeIn();
        $.post('https://prx_tablet/get_notas_ems');
    });
    $('#ems_perf_añadir_nota').click(function(){
        $('.pop_up').hide();
        $('#popUp_ems_nueva_nota').fadeIn();
    });

    $('#done_nota_ems').click(function(){
        var label = $('#input_ems_nota').val();
        if(label != ''){
            $.post('https://prx_tablet/add_nota_ems', JSON.stringify(label));
        }
        $('#input_ems_nota').val('');
    });

    $('#boton_ajustes').click(function(){
        $('.app').hide();
        $('#ajustes').fadeIn();
    });

    $('#aplicar_size').click(function(){
        var boxContent = $('#size_select').val();
        $.post('https://prx_tablet/cambiar_size', JSON.stringify(boxContent));
    });

    $('#boton_meca').click(function(){
        $('.app').hide();
        $('.meca_subApp').hide();
        $('#app_meca').fadeIn();
        $('#meca_princ').fadeIn();
    });

    $('#meca_bfichar').click(function(){
        $('#meca_princ').fadeOut();
        $('#meca_fichar').fadeIn();
    });

    $('#meca_bpers').click(function(){
        $('#meca_princ').fadeOut();
        $('#meca_buscar_pers').fadeIn();
    });

    $('#meca_btrt').click(function(){
        $('#meca_princ').fadeOut();
        $('#meca_tratamientos').fadeIn();
        $.post('https://prx_tablet/meca_get_trt');
    });

    $('#search_trt_meca').click(function(){
        var boxContent = $('#input_meca_trt').val();
        $.post('https://prx_tablet/search_mecaPrice',JSON.stringify(boxContent));
    });

    $('#meca_bpers_search').click(function(){
        $('#repers_content').html('');
        var boxContent = $('#input_meca_bpers').val();
        $.post('https://prx_tablet/meca_search_person',JSON.stringify(boxContent));
    });

    $('#volver_perf_meca').click(function(){
        $('#meca_perf_pers').fadeOut();
        $('.pop_up').fadeOut();
        $('#meca_perf_container_blat').hide();
        $('#meca_buscar_pers').fadeIn();
    });

    $('#meca_perf_añadir_trat').click(function(){
        $('.pop_up').hide();
        $('#popUp_nuevo_fine').fadeIn();
        $.post('https://prx_tablet/meca_get_list_trats');
    });
    $('#search_trat_meca').click(function(){
        var boxContent = $('#input_meca_trat_search').val();
        $.post('https://prx_tablet/search_mecaPriceList',JSON.stringify(boxContent));
    });

    $('#done_trat_meca').click(function(){
        var label = $('#input_meca_trat_label').val();
        var price = $('#input_meca_trat_price').val();
        var info = JSON.stringify({label:label,price:price});
        if(label != '' && price != ''){
            $.post('https://prx_tablet/add_fine', info);
        }
        $('#input_meca_trat_label').val('');
        $('#input_meca_trat_price').val('');
    });

    $('#perf_meca').click(function(){
        $('.table').hide();
        $('#container_historial_med').fadeIn();
        $.post('https://prx_tablet/get_hist_meca_perf')
    });

    $('#meca_perf_hist').click(function(){
        $('.meca_perf_tables').hide();
        $('#meca_tabla_hist').fadeIn();
        $('#meca_perf_container_blat').show();
        $('#meca_perf_añadir_trat').fadeIn();
        $('#meca_perf_añadir_nota').hide();
    });
    $('#meca_perf_notas').click(function(){
        $('.meca_perf_tables').hide();
        $('#meca_tabla_notes').fadeIn();
        $('#meca_perf_container_blat').show();
        $('#meca_perf_añadir_trat').hide();
        $('#meca_perf_añadir_nota').fadeIn();
        $.post('https://prx_tablet/get_notas_meca');
    });
    $('#meca_perf_añadir_nota').click(function(){
        $('.pop_up').hide();
        $('#popUp_meca_nueva_nota').fadeIn();
    });

    $('#done_nota_meca').click(function(){
        var label = $('#input_meca_nota').val();
        if(label != ''){
            $.post('https://prx_tablet/add_nota_meca', JSON.stringify(label));
        }
        $('#input_meca_nota').val('');
    });
});