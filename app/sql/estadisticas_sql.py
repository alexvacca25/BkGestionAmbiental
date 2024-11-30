class GestionEstadisticas:
    PANEL_CONTROL="CALL GenerarEstadisticas('usuarios,roles,residuos,tratamiento_residuos,transporte')"
    PANEL_CONTROL_GRAFICO="CALL ObtenerTotalResiduosPorMes()"
   

gestionEstadisticas = GestionEstadisticas()