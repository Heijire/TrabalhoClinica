use master
go
drop database Clinica
go
create database Clinica
go
use Clinica

Create table Pessoa(
	IdPessoa int not null,
	Nome varchar(50) not null,
	Rg int not null,
	DigitoRg int not null,
	Telefone int not null
	primary key(IdPessoa)
)

Create table cliente(
	IdCliente int not null,
	DataNascimento Date not null,
	Senha varchar(30) not null
	primary key (IdCliente) 
	Foreign Key (IdCliente)references Pessoa(IdPessoa)
)
Create table Especialidade(
	Id_especialidade int not null,
	Nome_especialidade varchar(30) not null,
	ValorBase decimal(7,2) not null
	Primary key (Id_especialidade)

)
create table Medico(
	IdMedico int not null,
	Id_especialidade  int not null,
	Porcentagem int  not null,
	Periodo varchar(10) not null
	primary key (IdMedico) 
	Foreign Key (IdMedico)references Pessoa(IdPessoa),
	Foreign Key (Id_especialidade) references Especialidade(Id_especialidade )
)

Create table Material(
	Id_Material int not null,
	Nome varchar(30) not null,
	Valor_Unitario decimal(7,2) not null
	Primary key (Id_Material)
)
Create table Consulta(
	Id_Consulta int not null,
	Data_consulta date not null,
	Valor_Consulta decimal(7,2) not null,
	Valor_material decimal(7,2) not null,
	TipoConsulta varchar(30) not null,
	TipoPlano varchar(30) not null,
	IdCliente int not null,
	IdMedico int not null,
	Id_especialidade int not null
	Primary Key (Id_Consulta)
	Foreign Key (IdCliente)references Cliente(IdCliente),
	Foreign Key (IdMedico)references Medico(IdMedico)
)
Go
Create table Material_consulta(
	Id_Consulta int not null,
	Quantidade_Material int not null,
	Id_Material int not null
	Primary Key (Id_Consulta, Id_Material)
	Foreign Key (Id_Material)references Material(Id_Material),
	Foreign Key (Id_Consulta)references Consulta(Id_Consulta)

)
--Algumas informações
-- Tabela Pessoa
INSERT INTO Pessoa (IdPessoa, Nome, Rg, DigitoRg, Telefone) VALUES 
(1, 'João Silva', 1234567, 8, 112233445),
(2, 'Maria Souza', 7654321, 9, 119876543),
(3, 'Carlos Lima', 9876543, 7, 114455667);

-- Tabela Cliente
INSERT INTO Cliente (IdCliente, DataNascimento, Senha) VALUES 
(1, '1990-05-10', 'senha123'),
(2, '1985-11-20', 'minhasenha');

-- Tabela Especialidade
INSERT INTO Especialidade (Id_especialidade, Nome_especialidade, ValorBase) VALUES 
(1, 'Cardiologia', 350.00),
(2, 'Ortopedia', 280.50);

-- Tabela Medico
INSERT INTO Medico (IdMedico, Id_especialidade, Porcentagem, Periodo) VALUES 
(3, 1, 30, 'Manhã'),
(2, 2, 25, 'Tarde');

-- Tabela Material
INSERT INTO Material (Id_Material, Nome, Valor_Unitario) VALUES 
(1, 'Seringa', 5.00),
(2, 'Luvas', 2.50),
(3, 'Álcool', 3.00);

-- Tabela Consulta
INSERT INTO Consulta (Id_Consulta, Data_consulta, Valor_Consulta, Valor_material, TipoConsulta, TipoPlano, IdCliente, IdMedico, Id_especialidade) VALUES 
(1, '2025-04-01', 400.00, 10.00, 'Particular', 'Nenhum', 1, 3, 1),
(2, '2025-04-02', 320.00, 5.00, 'Plano', 'Unimed', 2, 2, 2);

-- Tabela Material_consulta
INSERT INTO Material_consulta (Id_Consulta, Quantidade_Material, Id_Material) VALUES 
(1, 1, 1),
(1, 2, 2),
(2, 1, 3);
--
go
--Recebe o Rg antes de cadastrar, e também recebera seu digito de verifica,
--Caso invalido retorna 1
Create Procedure ValidarRg(@rg int , @DigitoRg int , @saida bit output )
as	declare 		
	@texto varchar(100)
	set @saida = 0
	If LEN(@Rg) <> 9
    Begin
        raiserror('RG inválido: O número do RG deve ter 9 dígitos.', 16, 1)
        set @saida =1
		Return
    End
	else If @Rg NOT LIKE '%[0-9]%' 
    Begin
	    raiserror('RG inválido: O RG deve conter apenas números.', 16 ,1)
		set @saida = 1
		return
	End 
	else If (Select count(*) from Pessoa 
			Where Rg = @Rg) >= 1 
		Begin
			raiserror( 'RG já cadastrado.', 16, 1)
			set @saida = 1
			Return
		End
	declare 
		@peso int, @soma int, @resto int,
		@cont int, @verifica int, @RgString varchar(9)
		set @soma = 0 
		set @peso = 2 
		set @cont = 1
		set @RgString = Right('00000000' + CAST(@rg AS VARCHAR(8)), 8)

		while @cont <=8
		begin
			set @soma = @soma + (CAST(SUBSTRING(@RgString, @cont, 1) AS INT) * @peso)
			set @peso = @peso +1
			set @cont = @cont +1
		end
	Set @resto = @soma % 11
	If @resto < 2
		Begin
			Set @verifica = 0;
		End
		Else BEGIN
			SET @verifica = 11 - @resto;
		END
		
		If(@DigitoRg != @verifica) 
		begin
			set @texto = 'Este rg ( ' + @RgString + ' - ' + (cast(@DigitoRg as char(1))) + ') é Invalido'
			raiserror(@texto, 16, 1)
			set @saida = 1
			return
		end
go
--Essa procedure Valida a senha de acordo com a regra de negocio, 
--onde a senha deve ter no minimo 8 digitos e ter pelo menos um numero.
--Caso invalido retorna 1
Create Procedure ValidaSenha(@Senha varchar(30), @saida bit output)
as	
	set @saida = 0
	if len(@Senha) < 8 or @Senha not like '%[0-9]'
	begin
		raiserror('A senha deve ter 8 caracteres, pelo menos 1 deles deve ser numérico.', 16, 1)
		set @saida = 1
	end
go
--Essa procedure, ira fazer o login do cliente, Recebe rg e senha
--Assim, tentará entrar e localizar uma conta
--Caso invalido retorna 1
Create procedure Autentificar(@rg int, @senha varchar(30), @IdCliente int output, @saida bit output)
as  Declare
	@senhasalva varchar(30)
	set @saida = 0
	
	select @senhasalva = Senha
	From Cliente
	Inner join Pessoa 
	on cliente.IdCliente = Pessoa.IdPessoa
	where Pessoa.rg = @rg 
	
	If @senhasalva != @senha
		begin
			raiserror('Senha incorreta. Tente novamente', 16, 1)
			Set @saida = 1
			return
		end
	Select @IdCliente = IdPessoa
	from Pessoa 
	where Pessoa.rg = @rg 
		Print 'Login realizado com sucesso.'
go
--Essa procedure validará se a data da consulta desejada é valida
--De acordo com a regra de negocio de 30 dias corridos
--Caso contrario retorna 1
Create Procedure ValidarData(@DataConsulta date, @saida bit output)
as	set @saida	= 0
	if (Datediff(day, getDate(), @DataConsulta)  > 30)
	begin
		raiserror('Impossivel de ser agendado, Data para consulta superior a 30 dias. ',16,1)	
		set @saida = 1
		return
	end
go
--Essa procedure, verificara se o cliente possui maioridade de acordo com a regra do negocio
--Caso invalido retorna 1
Create Procedure ValidarIdade(@DataNascimento date, @saida bit output )
as set @saida = 0
	if (Datediff(year, @DataNascimento, GetDate() ) < 18)
	begin
		raiserror('Cadastro Invalido, apenas maiores de idade podem realizar cadastro ', 16 , 1)
		set @saida = 1
		return
	end
go
--Essa Procidure verificará se a consulta solicitada é uma consulta, um retorno ou uma nova consulta
Create Procedure Validarretorno(@id_cliente int, @id_especialidade int, @dataNovaConsulta date, @saida varchar(20) output )
as declare
	@NumeroConsultas int
	select @NumeroConsultas = Count(*)
	From Consulta
		Where Id_Consulta = @id_cliente
		and id_especialidade = @id_especialidade
		and Datediff(day, Data_consulta, @dataNovaConsulta) <=30
	If @NumeroConsultas = 0
	begin
		set  @saida = 'Consulta '
	end
	else if @NumeroConsultas  = 1
	begin
		Set @saida  = 'Retorno'
	end	
	else
		begin set @saida = 'Nova Consulta'
	end


go
--Essa procedure é para verificar se tem pelo menos 3 medicos, um por periodo 
--De acordo com a regra de negocio
--Caso o contrario retorna 1 
Create procedure VerificaMedicos(@nomeespecialdade varchar(30), @saida bit output)
as set @saida = 0
	Declare 
	@manha int,
	@tarde int,
	@noite int

	Select @manha = COUNT(*)
	From Medico
	Inner join Especialidade
	on especialidade.Id_especialidade = Medico.Id_especialidade
	where especialidade.Nome_especialidade = @nomeespecialdade
	and Medico.Periodo = 'Manha'

	Select @tarde = COUNT(*)
	From Medico
	Inner join Especialidade
	on especialidade.Id_especialidade = Medico.Id_especialidade
	where especialidade.Nome_especialidade = @nomeespecialdade
	and Medico.Periodo = 'Tarde'
	Select @noite = COUNT(*)
	
	From Medico
	Inner join Especialidade
	on especialidade.Id_especialidade = Medico.Id_especialidade
	where especialidade.Nome_especialidade = @nomeespecialdade
	and Medico.Periodo = 'Noite'

	if @manha = 0 or @tarde = 0 or @noite = 0
	begin
		raiserror ('Não possui 1 medico em cada periodo dessa especialidade', 16,1)
		set @saida = 1
		return
	end


go

--Essa procedure, é usada para calcular o valor da consulta particular, somado com o valor do profisional
Create Procedure ValorParticular(@consulta int, @valor_Material decimal(7,2), @valortotal decimal(7,2) output)
as	declare
	@temp decimal(7,2), 
	@porcentagem int

	select @temp = Especialidade.ValorBase
	from Especialidade
	inner join Consulta
	on Consulta.Id_especialidade = Especialidade.Id_especialidade

	select @porcentagem = Medico.Porcentagem
	from Medico

	set @porcentagem = (@porcentagem / 100) + 1
	set @temp = @temp + @valor_Material
	set @valorTotal = @temp * @porcentagem
go
--Essa procedure, é usada para calcular o valor da consulta de plano,
--calculando o valor a ser repassado ao medico
Create Procedure ValorPlano(@consulta int, @valor_Material decimal(7,2), @valortotal decimal(7,2) output)
as	declare
	@temp decimal(7,2)	
	select @temp = Especialidade.ValorBase
	from Especialidade
	inner join Consulta
	on Consulta.Id_especialidade = Especialidade.Id_especialidade

	set @valortotal = @temp + @valor_Material
	set @temp = @valortotal / 15
	print(@temp)
go
--Essa procedure será utilizada para calcular o Preco, da consulta e 
--será enviada de acordo com o tipo da consulta
--cada um para uma procedure diferente
create Procedure calcular(@consulta int, @Tipo varchar(30), @Valor_Consulta decimal(7,2) OUTPUT, @Valor_material decimal(7,2) output)
AS

    SELECT @valor_material = SUM(Material.Valor_Unitario * Material_consulta.Quantidade_Material)
    FROM Consulta
    INNER JOIN Material_consulta ON Consulta.Id_Consulta = Material_consulta.Id_Consulta
    INNER JOIN Material ON Material.Id_Material = Material_consulta.Id_Material
    WHERE Consulta.Id_Consulta = @consulta
	if @Tipo = 'Particular'
	begin
		exec ValorParticular @consulta, @valor_Material, @Valor_Consulta output
	end else
	begin 
		exec ValorPlano @consulta, @valor_Material, @Valor_Consulta output
	end

go
go
--Essa procidure serve para o medico, com uma opção, ele ira verificar se os dados estao certos,
--caso sim fará a opcao escolhida entre atualizar, deletar ou adicionar 
Create procedure medico(@letra char(1),@Id int, @Nome varchar(50), @Rg int,@DigitoRg int, @Telefone int, @IdMedico int, @Id_especialidade  int, @Porcentagem int, @Periodo varchar(10), @saida varchar(100) output)
As declare
	@query varchar(300),
	@validorg bit,
	@cont int,
	@Nid int,
	@erro varchar(300)
	--deleta o medico, caso o id desejado exista
	if @letra = 'D' and @Rg is not null
	Begin
		Delete Medico 
		where Medico.IdMedico = @id
		set @saida = 'Medico Deletado com sucesso'
		Return
	End 
	--Verifica se tem o id desejado, caso contrario encerra
	else if @letra = 'D' and @Rg is null
	begin
		raiserror('RG invalido', 16, 1)
		return
	end
	else 
	begin
		--verifica se o rg digitado é valido
		Exec ValidarRg @Rg, @DigitoRg , @validorg  output
		If @validorg = 1
		Begin
			set @saida= 'ERRO'
			Return
		End 
		--Tenta inserir um novo medico
		else If @letra = 'C'
		Begin
			set @cont = (Select count(Pessoa.IdPessoa) FROM Pessoa)
			IF @cont = 0
			Begin
				set @Nid =1
			end else
			begin
				set @Nid = (select max(Pessoa.IdPessoa) + 1 from Pessoa)
				set @query = 'Insert into Pessoa(IdPessoa,Nome, Rg, DigitoRg,Telefone ) values (@Nid, @Nome, @Rg,@DigitoRg, @Telefone)  
					Insert into Medico (IdMedico, Id_especialidade, Porcentagem,Periodo) values (@Nid, @Id_especialidade, @Porcentagem, @Periodo) '
				begin try
					exec (@query) 
					set @saida = 'Medico adicionado com sucesso'
				end try
				begin catch
					SET @erro = ERROR_MESSAGE()
					IF (@erro LIKE '%PK%')
					BEGIN
						RAISERROR('ID já existente', 16, 1)
					END
					ELSE
					BEGIN
						RAISERROR('Erro de processamento', 16, 1)
					END
				end catch
				Return
			End 
		end
		--tenta atualizar o medico com o id desejado
		else if @letra = 'U'
		Begin 
			update Pessoa set Rg = @Rg, DigitoRg = @DigitoRg, Nome = @Nome, Telefone = @Telefone
			where Pessoa.IdPessoa = @Id
			Update Medico set Id_especialidade = @Id_especialidade, Porcentagem = @Porcentagem, Periodo = @Periodo
			where Medico.IdMedico = @Id
				set @saida = 'Medico atualizado com sucesso'
				Return
		End
		Else
		begin
			Raiserror('Opcao Invalida', 16, 1)
		End
	end

go
--Essa procidure serve para o paciente, com uma opção, ele ira verificar se os dados estao certos,
--caso sim fará a opcao escolhida entre atualizar, deletar ou adicionar 
Create procedure paciente(@letra char(1),@Id int, @Nome varchar(50), @Rg int,@DigitoRg int, @Telefone int, @DataNascimento  date, @Senha varchar(30), @saida varchar(100) output)
As declare
	@query varchar(300),
	@validorg bit,
	@validaridade bit,
	@validasenha bit,
	@cont int,
	@Nid int,
	@erro varchar(300)

	--verifica se o rg digitado é valido
	Exec ValidarRg @Rg, @DigitoRg , @validorg  output
	--VERIFICA MAIORIDADE
	EXEC ValidarIdade @DataNascimento, @validaridade  output
	--verifica regra de senha
	exec ValidaSenha @Senha, @validasenha output


	If @validorg = 1 or @validaridade = 1 or @validasenha = 1
	Begin
		set @saida= 'ERRO'
		Return
	End 
	--Tenta inserir um novo cliente
	else If @letra = 'C'
	Begin
		set @cont = (Select count(Pessoa.IdPessoa) FROM Pessoa)
		IF @cont = 0
		Begin
			set @Nid =1
		end else
		begin
			set @Nid = (select max(Pessoa.IdPessoa) + 1 from Pessoa)
			set @query = '	Insert into Pessoa (IdPessoa, Nome, Rg, DigitoRg, Telefone) values (@Nid, @Nome, @Rg, @DigitoRg, @Telefone)
							Insert into cliente values (IdCliente, DataNacimento, Senha) values (@Nid, @DataNascimento, @Senha)'
			begin try
				exec (@query) 
				set @saida = 'Paciente adicionado com sucesso'
			end try
			begin catch
				SET @erro = ERROR_MESSAGE()
				IF (@erro LIKE '%PK%')
				BEGIN
					RAISERROR('ID já existente', 16, 1)
				END
				ELSE
				BEGIN
					RAISERROR('Erro de processamento', 16, 1)
				END
			end catch
			Return
		End 
	end
	--tenta atualizar o paciente com o id desejado
	else if @letra = 'U'
	Begin 
		update Pessoa set Telefone = @Telefone
		where Pessoa.IdPessoa = @Id
		Update cliente set  Senha = @Senha, DataNascimento = @DataNascimento
		where cliente.IdCliente = @Id
			set @saida = 'Paciente atualizado com sucesso'
			Return
	End
	Else
	begin
		Raiserror('Opcao Invalida', 16, 1)
	End

go
--Essa procidure serve para a especialidade, com uma opção, ele ira verificar se os dados estao certos,
--caso sim fará a opcao escolhida entre atualizar, deletar ou adicionar 
create procedure especialidade(@letra char(1), @Id int , @Nome_especialidade varchar(30),	@ValorBase decimal(7,2), @saida varchar(100) output)
as declare
	@query varchar(300),
	@cont int,
	@Nid int,
	@erro varchar(300)
	--deleta a especialidade, caso o id desejado exista
	if @letra = 'D' and @Id is not null
	Begin
		Delete Especialidade 
		where Especialidade.Id_especialidade = @id
		set @saida = 'Especialidade Deletada com sucesso'
		Return
	End 
	--Verifica se tem o id desejado, caso contrario encerra
	else if @letra = 'D' and @Id is null
	begin
		raiserror('Id invalido', 16, 1)
		return
	end
	else 
		--Tenta inserir uma nova especialidade
		If @letra = 'C'
		Begin
			set @cont = (Select count(Especialidade.Id_especialidade) FROM Especialidade)
			IF @cont = 0
			Begin
				set @Nid =1
			end else
			begin
				set @Nid = (select max(Especialidade.Id_especialidade) + 1 from Especialidade)
				set @query = 'Insert into Especialidade(Id_especialidade, Nome_Especialidade, ValorBase) values (@Nid, @Nome_especialidade,	@ValorBase )'
				begin try
					exec (@query) 
					set @saida = 'Especialidade adicionado com sucesso'
				end try
				begin catch
					SET @erro = ERROR_MESSAGE()
					IF (@erro LIKE '%PK%')
					BEGIN
						RAISERROR('ID já existente', 16, 1)
					END
					ELSE
					BEGIN
						RAISERROR('Erro de processamento', 16, 1)
					END
				end catch
				Return
			End 
		end
		--tenta atualizar a especialidade com o id desejado
		else if @letra = 'U'
		Begin 
			Update Especialidade set ValorBase = @ValorBase, Nome_especialidade = @Nome_especialidade
			where Especialidade.Id_especialidade = @Id
				set @saida = 'Especialidade atualizado com sucesso'
				Return
		End
		Else
		begin
			Raiserror('Opcao Invalida', 16, 1)
		End
go
--Essa procidure serve para a consulta, com uma opção, ele ira verificar se os dados estao certos,
--caso sim fará a opcao escolhida entre atualizar, deletar ou adicionar 
create procedure consulta(@letra char(1), @Id_Consulta int,	@Data_consulta date, @Tipo varchar(30),
	@IdCliente int, @IdMedico int, @Id_especialidade int, @saida varchar(100) output)
as declare 	@query varchar(300),
		@cont int,
		@Nid int,
		@nome varchar(30),
		@verificaNumero bit,
		@datavalida int,
		@Valor_material decimal(7,2),
		@TIPOCONSULTA VARCHAR(20),
		@Valor_Consulta decimal(7,2),
		@erro varchar(300)
	--deleta a consulta, caso o id desejado exista
	if @letra = 'D' and @Id_Consulta is not null
	Begin
		Delete Consulta
		where Consulta.Id_Consulta = @Id_Consulta
		set @saida = 'Consulta Deletada com sucesso'
		Return
	End 
	--Verifica se tem o id desejado, caso contrario encerra
	else if @letra = 'D' and @Id_Consulta is null
	begin
		raiserror('Id invalido', 16, 1)
		return
	end
	else 
	begin 
	set @nome = (select Especialidade.Nome_especialidade 
	from Especialidade
	where Especialidade.Id_especialidade = @Id_especialidade)
		--Verifica regra de no minimo 1 medico por periodo
		exec VerificaMedicos @nome, @verificaNumero output 
		--VERIFICA se a dta segue o periodo de 30 dias
		exec ValidarData @Data_consulta, @datavalida output
		--Verifica se a consulta é retorno ou n
		exec Validarretorno @IdCliente, @Id_especialidade, @Data_consulta, @TIPOCONSULTA output
		--fazer calculo de valor d consulta
		exec calcular @Id_Consulta, @Tipo ,  @Valor_Consulta output , @Valor_material output 
		--Tenta inserir uma nova Consulta
	if(@verificaNumero <0 and @datavalida < 0)
	begin 
		raiserror('Erro, informação invalida',16,1)
		return
	end
	else	If @letra = 'C'
		Begin
			set @cont = (Select count(Consulta.Id_Consulta) FROM Consulta)
			IF @cont = 0
			Begin
				set @Nid =1
			end else
			begin
				set @Nid = (select max(Consulta.Id_Consulta) + 1 from Consulta)
				set @query = 'Insert into Consulta (Id_Consulta, Data_consulta, Valor_Consulta, Valor_material,TipoConsulta,TipoPlano,IdCliente ,IdMedico ,Id_especialidade  )
				values (@Nid, @Data_consulta, @Valor_Consulta, @Valor_material,@TIPOCONSULTA,@Tipo, @IdCliente, @IdMedico, @Id_especialidade )'
				begin try
					exec (@query) 
					set @saida = 'Consulta adicionado com sucesso'
				end try
				begin catch
					SET @erro = ERROR_MESSAGE()
					IF (@erro LIKE '%PK%')
					BEGIN
						RAISERROR('ID já existente', 16, 1)
					END
					ELSE
					BEGIN
						RAISERROR('Erro de processamento', 16, 1)
					END
				end catch
				Return
			End 
		end
		--tenta atualizar a especialidade com o id desejado
		else if @letra = 'U'
		Begin 
			Update Consulta set  Data_consulta = @Data_consulta, Valor_Consulta = @Valor_Consulta, TipoConsulta = @TIPOCONSULTA, TipoPlano = @Tipo, Id_especialidade = @Id_especialidade, IdMedico = @IdMedico, Valor_Consulta = @Valor_Consulta
			where Consulta.Id_Consulta = @Id_Consulta
				set @saida = 'Consulta atualizado com sucesso'
				Return
		End
		Else
		begin
			Raiserror('Opcao Invalida', 16, 1)
		End
	end

go
--Listar historico passado
create Procedure ListarConsultas(@letra char(1), @id_cliente int)
as
	If @letra = 'T'
	begin
		select * from Consulta
		where Consulta.IdCliente = @id_cliente 
		return 
	end
	else if @letra = 'P'	
	begin
		select * from Consulta
		where Consulta.IdCliente = @id_cliente 
		and Consulta.Data_consulta <= GETDATE()
		return
	end
	else if @letra = 'F'
	begin
		select * from Consulta
		where Consulta.IdCliente = @id_cliente 
		and Consulta.Data_consulta >= GETDATE()
		Return
	end 
	else
	begin
		raiserror('OPCAO INVALIDA', 16, 1)
		return
	end