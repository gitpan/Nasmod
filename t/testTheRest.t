use strict;
use Test;

BEGIN { plan tests => 6 }

use lib("../lib");
use Nasmod;

#------------------------------
# 1) addEntity, getEntity, merge
{
	my $model = Nasmod->new();
	$model->importBulk("model.nas");
	
	# entity count
	ok($model->count(), 6);

	my $entity1 = Entity->new();
	$entity1->setCol(1, "JIPEE");
	
	my $entity2 = Entity->new();
	my $entity3 = Entity->new();
	
	$model->addEntity($entity1);

	ok($model->count(), 7);
	
	$model->addEntity($entity2, $entity3);

	ok($model->count(), 9);
	
	my @entities = $model->getEntity(["", "JIPEE"]);
	
	ok(@entities, 1);
	
	$entity2->setCol(1, "JIPEE");
	
	@entities = $model->getEntity(["", "JIPEE"]);
	
	ok(@entities, 2);
	
	my $model2 = Nasmod->new();
	$model2->importBulk("model.nas");
	
	$model->merge($model2);
	
	ok($model->count(), 15);
	
}
#------------------------------

