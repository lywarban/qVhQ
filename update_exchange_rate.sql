DELIMITER $$

CREATE PROCEDURE UpdateExchangeRate(
    IN p_currency_id INT,
    IN p_exchange_rate DECIMAL(10, 4)
)
BEGIN
    -- Validar que currency_id y exchange_rate sean mayores que cero y no nulos
    IF p_currency_id IS NULL OR p_currency_id <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: currency_id debe ser mayor que cero.';
    ELSEIF p_exchange_rate IS NULL OR p_exchange_rate <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La tasa de cambio debe ser mayor que cero.';
    ELSE
        -- Actualizar la tasa de cambio si se cumplen las condiciones
        UPDATE currencies
        SET exchange_rate = p_exchange_rate
        WHERE currency_id = p_currency_id;
        
        -- Confirmar si la actualización tuvo éxito
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Advertencia: No se hizo ningún cambio, currency_id no encontrado.';
        END IF;
    END IF;
END $$

DELIMITER ;
