﻿select private.create_model(

-- Model name, schema, table

'opportunity_type', 'public', 'optype',

-- Columns
E'{
  "optype.optype_id as guid",
  "optype.optype_name as \\"name\\"",
  "optype.optype_descrip as description"}',

-- sequence

'public.optype_optype_id_seq',

-- Rules

E'{"

-- insert rule

create or replace rule \\"_CREATE\\" as on insert to xm.opportunity_type
  do instead

insert into optype (
  optype_id,
  optype_name,
  optype_descrip )
values (
  new.guid,
  new.name,
  new.description );

","

-- update rule

create or replace rule \\"_UPDATE\\" as on update to xm.opportunity_type
  do instead

update optype set
  optype_name = new.name,
  optype_descrip = new.description
where ( optype_id = old.guid );

","

-- delete rule

create or replace rule \\"_DELETE\\" as on delete to xm.opportunity_type
  do instead

delete from optype
where ( optype_id = old.guid );

"}',

-- Conditions, Comment, System

'{}', 'Opportunity Type Model', true);
