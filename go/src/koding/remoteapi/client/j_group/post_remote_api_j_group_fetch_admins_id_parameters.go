package j_group

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"time"

	"golang.org/x/net/context"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime"
	cr "github.com/go-openapi/runtime/client"

	strfmt "github.com/go-openapi/strfmt"
)

// NewPostRemoteAPIJGroupFetchAdminsIDParams creates a new PostRemoteAPIJGroupFetchAdminsIDParams object
// with the default values initialized.
func NewPostRemoteAPIJGroupFetchAdminsIDParams() *PostRemoteAPIJGroupFetchAdminsIDParams {
	var ()
	return &PostRemoteAPIJGroupFetchAdminsIDParams{

		timeout: cr.DefaultTimeout,
	}
}

// NewPostRemoteAPIJGroupFetchAdminsIDParamsWithTimeout creates a new PostRemoteAPIJGroupFetchAdminsIDParams object
// with the default values initialized, and the ability to set a timeout on a request
func NewPostRemoteAPIJGroupFetchAdminsIDParamsWithTimeout(timeout time.Duration) *PostRemoteAPIJGroupFetchAdminsIDParams {
	var ()
	return &PostRemoteAPIJGroupFetchAdminsIDParams{

		timeout: timeout,
	}
}

// NewPostRemoteAPIJGroupFetchAdminsIDParamsWithContext creates a new PostRemoteAPIJGroupFetchAdminsIDParams object
// with the default values initialized, and the ability to set a context for a request
func NewPostRemoteAPIJGroupFetchAdminsIDParamsWithContext(ctx context.Context) *PostRemoteAPIJGroupFetchAdminsIDParams {
	var ()
	return &PostRemoteAPIJGroupFetchAdminsIDParams{

		Context: ctx,
	}
}

/*PostRemoteAPIJGroupFetchAdminsIDParams contains all the parameters to send to the API endpoint
for the post remote API j group fetch admins ID operation typically these are written to a http.Request
*/
type PostRemoteAPIJGroupFetchAdminsIDParams struct {

	/*ID
	  Mongo ID of target instance

	*/
	ID string

	timeout time.Duration
	Context context.Context
}

// WithTimeout adds the timeout to the post remote API j group fetch admins ID params
func (o *PostRemoteAPIJGroupFetchAdminsIDParams) WithTimeout(timeout time.Duration) *PostRemoteAPIJGroupFetchAdminsIDParams {
	o.SetTimeout(timeout)
	return o
}

// SetTimeout adds the timeout to the post remote API j group fetch admins ID params
func (o *PostRemoteAPIJGroupFetchAdminsIDParams) SetTimeout(timeout time.Duration) {
	o.timeout = timeout
}

// WithContext adds the context to the post remote API j group fetch admins ID params
func (o *PostRemoteAPIJGroupFetchAdminsIDParams) WithContext(ctx context.Context) *PostRemoteAPIJGroupFetchAdminsIDParams {
	o.SetContext(ctx)
	return o
}

// SetContext adds the context to the post remote API j group fetch admins ID params
func (o *PostRemoteAPIJGroupFetchAdminsIDParams) SetContext(ctx context.Context) {
	o.Context = ctx
}

// WithID adds the id to the post remote API j group fetch admins ID params
func (o *PostRemoteAPIJGroupFetchAdminsIDParams) WithID(id string) *PostRemoteAPIJGroupFetchAdminsIDParams {
	o.SetID(id)
	return o
}

// SetID adds the id to the post remote API j group fetch admins ID params
func (o *PostRemoteAPIJGroupFetchAdminsIDParams) SetID(id string) {
	o.ID = id
}

// WriteToRequest writes these params to a swagger request
func (o *PostRemoteAPIJGroupFetchAdminsIDParams) WriteToRequest(r runtime.ClientRequest, reg strfmt.Registry) error {

	r.SetTimeout(o.timeout)
	var res []error

	// path param id
	if err := r.SetPathParam("id", o.ID); err != nil {
		return err
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}