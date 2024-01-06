	## Gerar impostos casas ##
UPDATE `casas` SET `impostos`=`impostos`+'1' WHERE `proprietario_id`!='0' AND `is_cash`=0;
UPDATE `casas` SET `proprietario_id`='0' WHERE `impostos`>'15' AND `proprietario_id`!='0';

	## Gerar impostos empresas ##
UPDATE `empresas` SET `impostos`=`impostos`+'1' WHERE `proprietario`!='Ninguem';
UPDATE `empresas` SET `proprietario`='Ninguem' WHERE `impostos`>'15' AND `proprietario`!='Ninguem';

	## Gerar contas hotel ##

UPDATE `hoteis` SET `impostos`=`impostos`+'1' WHERE `proprietario_id`!='0';
UPDATE `hoteis` SET `proprietario_id`='0' WHERE `impostos`>'7' AND `proprietario_id`!='0';
	
	## Gerar IPVA ##
UPDATE `veiculos` SET `ipva`=`ipva`+'1';
DELETE FROM `veiculos` WHERE `ipva`>'15';